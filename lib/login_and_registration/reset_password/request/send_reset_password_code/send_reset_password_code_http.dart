import 'dart:convert';

import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/send_reset_password_code/request_reset_password_code_status.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/send_reset_password_code/send_reset_password_code_request.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/error_message.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';
import '../../../common/result.dart';
import 'package:http/http.dart' as http;

class SendResetPasswordCodeHttp extends SendResetPasswordCodeRequest {
  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(RequestResetPasswordCodeStatus.ok);
    } else {
      return Result.error(RequestResetPasswordCodeStatus.error);
    }
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if (error.errorMessage == "Account not active") {
      return Result.error(RequestResetPasswordCodeStatus.accountNotActive);
    }else if (error.errorMessage == "User not found"){
      return Result.error( RequestResetPasswordCodeStatus.userNotExist);
    }
    else
    {
      return Result.error(RequestResetPasswordCodeStatus.error);
    }
  }


  @override
  Future<Result> sendResetPasswordCode(EmailData email) async {
    var bodyEmail = jsonEncode(email);

    var httpHelper = HttpHelper(http.Client());
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.sendResetPasswordCode,
        body: bodyEmail,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }

    } catch (e) {
      return Result.error(RequestResetPasswordCodeStatus.error);
    }
  }
}