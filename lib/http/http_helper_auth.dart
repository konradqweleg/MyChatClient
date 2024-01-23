import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:my_chat_client/http/refresh_token_request_status.dart';
import 'package:my_chat_client/http/request_refresh_access_token_http.dart';

import '../login_and_registration/common/result.dart';
import '../login_and_registration/login/data/auth_data.dart';
import 'acess_token_data.dart';


enum TokenCheckStatus {
  ok,
  error,
  timeout,
  refreshTokenExpired,
  accessTokenExpired,
  redirectToLoginPage,
}

enum AccessTokenStatus{
  ok,
  tokenExpired,
  error,
  notFound,
  saved
}

enum SavedCredentialsStatus{
  ok,
  error,
  notFound,
}

enum RefreshTokenStatus{
  ok,
  error,
  notFound,
  noCheck,
}

enum AuthErrorStatus{
  tokenExpired,
}

class HttpHelperAuth {

   Future<Result<RefreshTokenStatus>> checkRefreshToken() async {
    Future<String?> refreshToken = AuthData.getRefreshToken();
    return  refreshToken.then((token) {
      if(token == null){
        return Result.error(RefreshTokenStatus.notFound);
      }
      else{
        return Result.success(RefreshTokenStatus.ok);
      }
    });
  }

   Future<Result<AccessTokenStatus>> checkAccessToken() async {
    Future<String?> accessToken = AuthData.getAccessToken();
    return  accessToken.then((token) {
      if(token == null){
        return Result.error(AccessTokenStatus.notFound);
      }
      else{
        return Result.success(AccessTokenStatus.saved);
      }
    });
  }

   Future<Result<SavedCredentialsStatus>> checkSavedCredentials() async {
    String? email = await AuthData.getEmail();
    String? password = await AuthData.getPassword();

   if(email != null && password != null) {
     return Result.success(SavedCredentialsStatus.ok);
   }
   else{
     return Result.error(SavedCredentialsStatus.notFound);
   }
  }

  Future<Result> getWithTimeout(String url,dynamic body, {Duration timeoutDuration = const Duration(seconds: 3),}) async {

    Result<AccessTokenStatus> accessTokenStatus = await checkAccessToken();
    Result<RefreshTokenStatus> refreshTokenStatus = Result.success(RefreshTokenStatus.noCheck);

    if(accessTokenStatus.isError()){
      print("Nie znaleziono access tokena");
      refreshTokenStatus = await checkRefreshToken();
    }

    if(refreshTokenStatus.isError()){
      print("Nie znaleziono refresh tokena i access tokena przekierowuje do logowania");
      return Result.error(TokenCheckStatus.redirectToLoginPage);
    }


    if(accessTokenStatus.isSuccess()){
      String? token = await AuthData.getAccessToken();
      if(token == null){
        print("Sprawdzenie pobranego access tokena nie powiodło się jest on pusty");
        return Result.error(TokenCheckStatus.redirectToLoginPage);
      }else{
        Result resultRequestWithAccessToken = await _requestGETAuthWithTimeout(url,token,body: body,timeoutDuration: timeoutDuration);
        if(resultRequestWithAccessToken.isSuccess()){
          print("Znaleziono access tokena");
          return resultRequestWithAccessToken;
        }else if(resultRequestWithAccessToken.isError() &&  resultRequestWithAccessToken.getData() == TokenCheckStatus.accessTokenExpired){


          refreshTokenStatus = await checkRefreshToken();
          if(refreshTokenStatus.isError()){
            print("Nie znaleziono refresh tokena");
            return Result.error(TokenCheckStatus.redirectToLoginPage);
          }

          print("Nie znaleziono access tokena3");
          String refreshToken = await AuthData.getRefreshToken() as String;
          RequestRefreshAccessTokenHttp requestRefreshAccessTokenHttp = RequestRefreshAccessTokenHttp();
          Result resultRefreshAccessToken = await requestRefreshAccessTokenHttp.refreshAccessToken(refreshToken);
          print(resultRefreshAccessToken.getData());

          if(resultRefreshAccessToken.isSuccess()){
            print("Znaleziono access tokena4");
            AccessTokenData tokens = resultRefreshAccessToken.getData() as AccessTokenData;
            AuthData.saveAccessToken(tokens.accessToken);
            return await _requestGETAuthWithTimeout(url,tokens.accessToken,body: body,timeoutDuration: timeoutDuration);
          }
          else if(resultRefreshAccessToken.isError() && resultRefreshAccessToken.getData() == RefreshTokenRequestStatus.noAuthorized){
            print("Nie znaleziono access tokena5");
            return Result.error(TokenCheckStatus.redirectToLoginPage);
          }else{
            print("Nie znaleziono access tokena6");
            return Result.error(TokenCheckStatus.error);
          }
        }
        else {
          print("Nie znaleziono access tokena3");
          RequestRefreshAccessTokenHttp requestRefreshAccessTokenHttp = RequestRefreshAccessTokenHttp();
          Result resultRefreshAccessToken = await requestRefreshAccessTokenHttp.refreshAccessToken(token);
          print(resultRefreshAccessToken.getData());

          if(resultRefreshAccessToken.isSuccess()){
            print("Znaleziono access tokena4");
            AccessTokenData tokens = resultRefreshAccessToken.getData() as AccessTokenData;
            AuthData.saveAccessToken(tokens.accessToken);
            return await _requestGETAuthWithTimeout(url,tokens.accessToken,body: body,timeoutDuration: timeoutDuration);
          }
          else if(resultRefreshAccessToken.isError() && resultRefreshAccessToken.getData() == RefreshTokenRequestStatus.noAuthorized){
            print("Nie znaleziono access tokena5");
            return Result.error(TokenCheckStatus.redirectToLoginPage);
          }else{
            print("Nie znaleziono access tokena6");
            return Result.error(TokenCheckStatus.error);
          }

        }
      }
    }
    else{
      print("Nie znaleziono access tokena7");
      return Result.error(TokenCheckStatus.redirectToLoginPage);
    }


    return refreshTokenStatus;


    //
    // actualRequestResult = checkAccessToken();
    //
    // actualRequestResult.then((value) => {
    //   if(value.isError()){
    //     checkSavedCredentials().then((value) => {
    //       if(value.isSuccess()){
    //         //executeHttpWithTryRefreshTokenRequestWithTimeout()
    //       }
    //       else{
    //         return Result.error(TokenCheckStatus.redirectToLoginPage);
    //       }
    //     })
    //   }
    // });
    //
    // if(checkAccessTokenResult()){
    //   return checkAccessTokenResult;
    // }
    //
    //
    //
    // print("1");
    // Future<String?> accessToken = AuthData.getAccessToken();
    //
    //
    //
    // return  accessToken.then((token) {
    //   print("2");
    //   if(token == null){
    //     print("3");
    //     return Result.error(TokenCheckStatus.redirectToLoginPage);
    //   }
    //
    //   Future<dynamic> result = requestGETAuthWithTimeout(url,token,body: body,timeoutDuration: timeoutDuration);
    //   return result.then((value) {
    //     print(value);
    //     if(value is http.Response){
    //       if(value.statusCode == 200){
    //         return Result.success(value);
    //       }
    //       else if(value.statusCode == 401){
    //         return Result.error(TokenCheckStatus.accessTokenExpired);
    //       }
    //       else if(value.statusCode == 403){
    //         return Result.error(TokenCheckStatus.refreshTokenExpired);
    //       }
    //       else{
    //         return Result.error(TokenCheckStatus.error);
    //       }
    //     }
    //     else if(value is TimeoutException){
    //       return Result.error(TokenCheckStatus.timeout);
    //     }
    //     else{
    //       return Result.error(TokenCheckStatus.error);
    //     }
    //   });



     // else{
     //   return ExecuteHttpWithAccessTokenRequestWithTimeoutStatus.ok;
     // }

     // return Result.error(TokenCheckStatus.redirectToLoginPage);
    //});

  }

  // Future<dynamic> executeHttpWithTryRefreshTokenRequestWithTimeout(){
  //
  // }
  //
  // void redirectToLoginPage(){
  //
  // }




  Future<Result> _requestGETAuthWithTimeout(
      String url,String accessToken, {
        dynamic body,
        Duration timeoutDuration = const Duration(seconds: 3),
      }) async {
    try {

      Map<String, String>? headers =  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      };


      var client = http.Client();
      var response;
      try {
        response = await Future.any([
          client.get(
            Uri.parse(url),
            headers: headers,
          ),
          Future.delayed(timeoutDuration),
        ]);
      } on TimeoutException {
        throw TimeoutException('Request timed out');
      }



      if (response is http.Response) {
        if (response.statusCode == 200 || response.statusCode == 400) {
          return Result.success(response.body);
        }else if (response.statusCode == 401) {
          return Result.error(TokenCheckStatus.accessTokenExpired);
        }
        else {
          throw Exception('Request failed with status: ${response.statusCode}');
        }
      } else {
        throw Exception('Unknown response');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }
}