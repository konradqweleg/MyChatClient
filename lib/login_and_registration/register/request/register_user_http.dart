import 'dart:convert';
import 'package:my_chat_client/http/request_response_general/error_message.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/http/request_response_general/status.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../../../http/http_helper.dart';
import '../../../requests/requests_url.dart';
import '../../common/result.dart';

class RegisterUserHttpRequest extends RegisterUserRequest {
  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(RegisterResponseStatus.ok);
    } else {
      return Result.error(RegisterResponseStatus.error);
    }
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if(error.errorMessage.contains("Account not active")){
      return Result.error(RegisterResponseStatus.accountNotActive);
    }
    else if(error.errorMessage.contains("User already exist")){
      return Result.error(RegisterResponseStatus.userAlreadyExists);
    }
    else{
      return Result.error(RegisterResponseStatus.error);
    }
  }

  @override
  Future<Result> register(
      UserRegisterData userRegisterData) async {
    var bodyUserRegisterData = jsonEncode(userRegisterData);

    var httpHelper = HttpHelper();
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.register,
        body: bodyUserRegisterData,
      );
     

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }
    } catch (e) {
      return Result.error(RegisterResponseStatus.error);
    }
  }
}

