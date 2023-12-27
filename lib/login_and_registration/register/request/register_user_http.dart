import 'dart:convert';
import 'package:my_chat_client/http/request_response_general/error_message.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/http/request_response_general/status.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../../../http/http_helper.dart';
import '../../../requests/requests_url.dart';

class RegisterUserHttpRequest extends RegisterUserRequest {
  RegisterResponseStatus _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return RegisterResponseStatus.ok;
    } else {
      return RegisterResponseStatus.error;
    }
  }

  RegisterResponseStatus _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessage error = ErrorMessage.fromJson(parsedResponse);

    if (error.errorMessage == "Account not active") {
      return RegisterResponseStatus.accountNotActive;
    } else if (error.errorMessage == "User already exist") {
      return RegisterResponseStatus.userAlreadyExists;
    } else {
      return RegisterResponseStatus.error;
    }
  }

  @override
  Future<RegisterResponseStatus> register(
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
      return RegisterResponseStatus.error;
    }
  }
}
