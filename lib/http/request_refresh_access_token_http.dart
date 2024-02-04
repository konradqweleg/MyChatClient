import 'dart:convert';

import 'package:my_chat_client/http/request_data/acess_token_data.dart';
import 'package:my_chat_client/http/request_status/refresh_token_request_status.dart';
import '../login_and_registration/common/result.dart';
import '../requests/requests_url.dart';
import 'http_helper.dart';
import 'package:http/http.dart' as http;

class RequestRefreshAccessTokenHttp{
  final http.Client httpClient;
  RequestRefreshAccessTokenHttp(this.httpClient);

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    AccessTokenData tokens = AccessTokenData.fromJson(parsedResponse);
    return Result.success(tokens);
  }

  Result _getErrorResponseStatus(int responseCode) {
    if(responseCode == 401){
       return Result.error(RefreshTokenRequestStatus.noAuthorized);
    }
    else{
       return Result.error(RefreshTokenRequestStatus.error);
    }
  }


  @override
  Future<Result> refreshAccessToken(String? refreshToken) async{

    if(refreshToken == null){
      return Result.error(RefreshTokenRequestStatus.error);
    }

    var httpHelper = HttpHelper(httpClient);

    Map<String, String> headersWithRefreshToken = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $refreshToken'
    };

    try {

      var result = await httpHelper.executeHttpRequestWithTimeout(
        headers: headersWithRefreshToken,
        RequestsURL.refreshToken,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      }else{
        return _getErrorResponseStatus(result.statusCode);
      }

    } catch (e) {
      print(e);
      return Result.error(RefreshTokenRequestStatus.error);
    }
  }
}