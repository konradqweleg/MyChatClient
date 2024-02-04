import 'dart:convert';
import 'dart:io';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_error_status.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/Tokens.dart';

import '../../../http/http_helper.dart';
import '../../../http/request_response_general/error_message.dart';
import '../../../requests/requests_url.dart';
import 'package:http/http.dart' as http;

class LoginRequestHttp extends LoginRequest{

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Tokens tokens = Tokens.fromJson(parsedResponse);
    return Result.success(tokens);
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if (error.errorMessage == " Bad credentials ") {
      return Result.error(LoginRequestErrorStatus.badCredentials);
    }
    else
    {
      return Result.error(LoginRequestErrorStatus.error);
    }
  }


  @override
  Future<Result> login(LoginData loginData) async{
    var bodyLoginData = jsonEncode(loginData);


    var httpHelper = HttpHelper(http.Client());
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.login,
        body: bodyLoginData,
      );



      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }

    } catch (e) {
      return Result.error(LoginRequestErrorStatus.error);
    }
  }

}