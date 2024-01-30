import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:my_chat_client/http/refresh_token_request_status.dart';
import 'package:my_chat_client/http/request_refresh_access_token_http.dart';

import '../login_and_registration/common/result.dart';
import '../login_and_registration/login/data/auth_data.dart';
import 'request_data/acess_token_data.dart';

enum AuthRequestStatus {
  ok,
  error,
  timeout,
  refreshTokenExpired,
  accessTokenExpired,
  redirectToLoginPage,
}

enum _SavedTokenStatus {
  error,
  accessibleAccessToken,
  accessibleRefreshToken,
  noAccessAnyTokens,
}

enum _TypeOfRequest {
  get,
  post,
  put,
  delete,
}

class HttpHelperAuth {


  Future<Result> get(String url) async {
    return _requestWithCheckToken(_TypeOfRequest.get,url, null);
  }

  Future<Result> post(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.post,url, body);
  }

  Future<Result> put(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.put,url, body);
  }

  Future<Result> delete(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.delete,url, body);
  }

  Future<Result> _requestWithCheckToken(_TypeOfRequest requestType, String url, dynamic body, {Duration timeoutDuration = const Duration(seconds: 3),}) async {
    Result<_SavedTokenStatus> savedTokenStatus = await _checkSavedTokens();
    bool isRedirectToLoginPageDueLackOfAnyTokens = _isRedirectToLoginPageDueLackOfTokens(savedTokenStatus);
    if (isRedirectToLoginPageDueLackOfAnyTokens) {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    }

    if (savedTokenStatus.isSuccess() && savedTokenStatus.getData() == _SavedTokenStatus.accessibleAccessToken) {
      String? accessToken = await AuthData.getAccessToken();

      Result resultRequestWithAccessToken = await _request(requestType, url, accessToken!, body: body, timeoutDuration: timeoutDuration);

      if (resultRequestWithAccessToken.isSuccess()) {
        return resultRequestWithAccessToken;
      } else if (resultRequestWithAccessToken.isError() && resultRequestWithAccessToken.getData() == AuthRequestStatus.accessTokenExpired) {
        return _repeatGetRequestWithRefreshedAccessToken(requestType, url, body, timeoutDuration);
      } else {
        return Result.error(AuthRequestStatus.error);
      }
    } else if (savedTokenStatus.isSuccess() && savedTokenStatus.getData() == _SavedTokenStatus.accessibleRefreshToken) {
      return _repeatGetRequestWithRefreshedAccessToken(requestType, url, body, timeoutDuration);
    } else {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    }
  }

  Future<Result<_SavedTokenStatus>> _checkSavedTokens() async {
    String? accessToken = await AuthData.getAccessToken();
    String? refreshToken = await AuthData.getRefreshToken();

    if (accessToken != null) {
      return Result.success(_SavedTokenStatus.accessibleAccessToken);
    } else if (accessToken == null && refreshToken != null) {
      return Result.success(_SavedTokenStatus.accessibleRefreshToken);
    } else if (accessToken == null && refreshToken == null) {
      return Result.success(_SavedTokenStatus.noAccessAnyTokens);
    } else {
      return Result.error(_SavedTokenStatus.error);
    }
  }

  bool _isRedirectToLoginPageDueLackOfTokens(Result<_SavedTokenStatus> savedTokenStatus) {
    if (savedTokenStatus.isError() || savedTokenStatus.getData() == _SavedTokenStatus.noAccessAnyTokens) {
      return true;
    } else {
      return false;
    }
  }


  Future<Result> _repeatGetRequestWithRefreshedAccessToken(_TypeOfRequest requestType, url, body, timeoutDuration) async {
    String refreshToken = await AuthData.getRefreshToken() as String;
    RequestRefreshAccessTokenHttp requestRefreshAccessTokenHttp = RequestRefreshAccessTokenHttp();
    Result resultRefreshAccessToken = await requestRefreshAccessTokenHttp.refreshAccessToken(refreshToken);
    if (resultRefreshAccessToken.isSuccess()) {
      AccessTokenData tokens = resultRefreshAccessToken.getData() as AccessTokenData;
      AuthData.saveAccessToken(tokens.accessToken);
      return await _request(requestType,url, tokens.accessToken, body: body, timeoutDuration: timeoutDuration);
    } else if (resultRefreshAccessToken.isError() && resultRefreshAccessToken.getData() == RefreshTokenRequestStatus.noAuthorized) {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    } else {
      print("Request failed with status:}"+resultRefreshAccessToken.getData().toString());
      return Result.error(AuthRequestStatus.error);
    }
  }


  Future<Result> _request(
    _TypeOfRequest requestType,
    String url,
    String accessToken, {
    dynamic body,
    Duration timeoutDuration = const Duration(seconds: 3),
  }) async {
    Map<String, String>? headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    if(requestType == _TypeOfRequest.get && body != null){
      throw Exception('Body is not null');
    }


    var client = http.Client();
    late dynamic response;

    try {
      response = await Future.any([
        if (requestType == _TypeOfRequest.get)
          client.get(Uri.parse(url), headers: headers),
        if (requestType == _TypeOfRequest.post)
          client.post(Uri.parse(url), headers: headers, body: body),
        if (requestType == _TypeOfRequest.put)
          client.put(Uri.parse(url), headers: headers, body: body),
        if (requestType == _TypeOfRequest.delete)
          client.delete(Uri.parse(url), headers: headers),
        Future.delayed(timeoutDuration),
      ]);
    } on TimeoutException {
      return Result.error(AuthRequestStatus.timeout);
    } catch (e) {
      return Result.error(AuthRequestStatus.error);
    }


    if (response is http.Response) {
      if (response.statusCode == 200 || response.statusCode == 400) {
        return Result.success(response.body);
      } else if (response.statusCode == 401) {
        return Result.error(AuthRequestStatus.accessTokenExpired);
      } else {
        return Result.error(AuthRequestStatus.error);
      }
    } else {
      return Result.error(AuthRequestStatus.error);
    }
  }

}
