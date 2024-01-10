import 'dart:convert';

import 'package:my_chat_client/login_and_registration/reset_password/check/requests/check_exists_email_request.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/error_message.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';
import '../../../common/result.dart';
import '../../../confirm_code/request/resend_active_account_code/email_data.dart';
import 'check_exists_email_status.dart';

class CheckEmailExistsHttp implements CheckExistsEmailRequest{

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(RequestCheckExistsEmailStatus.ok);
    } else {
      return Result.error(RequestCheckExistsEmailStatus.error);
    }
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if (error.errorMessage == "Account not active") {
      return Result.error(RequestCheckExistsEmailStatus.accountNotActive);
    }else if (error.errorMessage == "User not found"){
      return Result.error( RequestCheckExistsEmailStatus.userNotExist);
    }
    else
    {
      return Result.error(RequestCheckExistsEmailStatus.error);
    }
  }
  @override
  Future<Result> isEmailExistsInService(EmailData email) async {
    var bodyEmail = jsonEncode(email);

    var httpHelper = HttpHelper();
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.checkIsUserWithThisEmailExist,
        body: bodyEmail,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }

    } catch (e) {
      return Result.error(RequestCheckExistsEmailStatus.error);
    }
  }

}