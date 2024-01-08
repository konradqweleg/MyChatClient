import 'dart:convert';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_status.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';

class ResendConfirmAccountCodeRequestHttp extends ResendConfirmAccountCodeRequest{

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(ResendConfirmAccountCodeStatus.ok);
    } else {
      return Result.error(ResendConfirmAccountCodeStatus.error);
    }
  }

  @override
  Future<Result> resendActiveAccountCode(EmailData emailData) async {

    var bodyEmailData = jsonEncode(emailData);

    var httpHelper = HttpHelper();
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.resendActiveAccountCode,
        body: bodyEmailData,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return Result.error(ResendConfirmAccountCodeStatus.error);
      }

    } catch (e) {
      return Result.error(ResendConfirmAccountCodeStatus.error);
    }
  }
 
}