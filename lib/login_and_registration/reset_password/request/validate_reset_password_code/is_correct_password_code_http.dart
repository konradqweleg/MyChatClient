import 'dart:convert';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/email_and_code_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/is_correct_reset_password_code.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/error_message.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';
import 'Is_correct_password_code_request_status.dart';

class IsCorrectPasswordCodeHttp extends IsCorrectResetPasswordCode {

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(IsCorrectPasswordCodeRequestStatus.ok);
    } else {
      return Result.error(IsCorrectPasswordCodeRequestStatus.error);
    }
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if (error.errorMessage == "Wrong reset password code") {
      return Result.error(IsCorrectPasswordCodeRequestStatus.badCode);
    }else if (error.errorMessage == "Reset password code not found"){
      return Result.error( IsCorrectPasswordCodeRequestStatus.resetPasswordCodeNotFoundForThisUser);
    }
    else
    {
      return Result.error(IsCorrectPasswordCodeRequestStatus.error);
    }
  }

  @override
  Future<Result> isCorrectResetPasswordCode(EmailAndCodeData emailAndCodeData) async {
    var bodyEmailAndCode = jsonEncode(emailAndCodeData);

    var httpHelper = HttpHelper();
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.checkIsCorrectResetPasswordCode,
        body: bodyEmailAndCode,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }

    } catch (e) {
      return Result.error(IsCorrectPasswordCodeRequestStatus.error);
    }
  }


}