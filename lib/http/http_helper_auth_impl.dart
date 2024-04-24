import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:my_chat_client/http/request_status/auth_request_status.dart';
import 'package:my_chat_client/http/request_status/refresh_token_request_status.dart';
import 'package:my_chat_client/http/request_refresh_access_token_http.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import '../login_and_registration/common/result.dart';
import '../tokens/saved_token_status.dart';
import 'http_helper_auth.dart';
import 'request_data/acess_token_data.dart';

enum _TypeOfRequest {
  get,
  post,
  put,
  delete,
}

class HttpHelperAuthImpl implements HttpHelperAuth {

  final http.Client httpClient;
  HttpHelperAuthImpl(this.httpClient, this.tokenManager);
  TokenManager tokenManager;

  @override
  Future<Result> get(String url) async {
    return _requestWithCheckToken(_TypeOfRequest.get,url, null);
  }

  @override
  Future<Result> post(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.post,url, body);
  }

  @override
  Future<Result> put(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.put,url, body);
  }

  @override
  Future<Result> delete(String url, dynamic body) async {
    return _requestWithCheckToken(_TypeOfRequest.delete,url, body);
  }

  Future<Result> _requestWithCheckToken(_TypeOfRequest requestType, String url, dynamic body, {Duration timeoutDuration = const Duration(seconds: 3),}) async {
    Result<SavedTokenStatus> savedTokenStatus = await tokenManager.checkSavedTokens();

    bool isRedirectToLoginPageDueLackOfAnyTokens = _isRedirectToLoginPageDueLackOfTokens(savedTokenStatus);

    if (isRedirectToLoginPageDueLackOfAnyTokens) {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    }


    if (savedTokenStatus.isSuccess() && savedTokenStatus.getData() == SavedTokenStatus.accessibleAccessToken) {
      String? accessToken =  await tokenManager.getAccessToken();

      Result resultRequestWithAccessToken = await _request(requestType, url, accessToken!, body: body, timeoutDuration: timeoutDuration);



      if (resultRequestWithAccessToken.isSuccess()) {
        return resultRequestWithAccessToken;
      } else if (resultRequestWithAccessToken.isError() && resultRequestWithAccessToken.getData() == AuthRequestStatus.accessTokenExpired) {
        return _repeatGetRequestWithRefreshedAccessToken(requestType, url, body, timeoutDuration);
      } else {
        return Result.error(AuthRequestStatus.error);
      }
    } else if (savedTokenStatus.isSuccess() && savedTokenStatus.getData() == SavedTokenStatus.accessibleRefreshToken) {
      return _repeatGetRequestWithRefreshedAccessToken(requestType, url, body, timeoutDuration);
    } else {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    }
  }



  bool _isRedirectToLoginPageDueLackOfTokens(Result<SavedTokenStatus> savedTokenStatus) {
    if (savedTokenStatus.isError() || savedTokenStatus.getData() == SavedTokenStatus.noAccessAnyTokens) {
      return true;
    } else {
      return false;
    }
  }


  Future<Result> _repeatGetRequestWithRefreshedAccessToken(_TypeOfRequest requestType, url, body, timeoutDuration) async {
    String? refreshToken = await tokenManager.getRefreshToken();
    RequestRefreshAccessTokenHttp requestRefreshAccessTokenHttp = RequestRefreshAccessTokenHttp(httpClient);
    Result resultRefreshAccessToken = await requestRefreshAccessTokenHttp.refreshAccessToken(refreshToken);
    if (resultRefreshAccessToken.isSuccess()) {
      AccessTokenData tokens = resultRefreshAccessToken.getData() as AccessTokenData;
      tokenManager.saveAccessToken(tokens.accessToken);
      return await _request(requestType,url, tokens.accessToken, body: body, timeoutDuration: timeoutDuration);
    } else if (resultRefreshAccessToken.isError() && resultRefreshAccessToken.getData() == RefreshTokenRequestStatus.noAuthorized) {
      return Result.error(AuthRequestStatus.redirectToLoginPage);
    } else {
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



    late dynamic response;

    try {
      response = await Future.any([
        if (requestType == _TypeOfRequest.get)
          httpClient.get(Uri.parse(url), headers: headers),
        if (requestType == _TypeOfRequest.post)
          httpClient.post(Uri.parse(url), headers: headers, body: body),
        if (requestType == _TypeOfRequest.put)
          httpClient.put(Uri.parse(url), headers: headers, body: body),
        if (requestType == _TypeOfRequest.delete)
          httpClient.delete(Uri.parse(url), headers: headers),
        Future.delayed(timeoutDuration),
      ]);
    } on TimeoutException {
      return Result.error(AuthRequestStatus.timeout);
    } catch (e) {

      return Result.error(AuthRequestStatus.error);
    }


    if (response is http.Response) {

      print(response.statusCode);
      print(response.body);
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
