import 'dart:convert';

import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_data.dart';

import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request_status.dart';

import '../../../http/http_helper.dart';
import '../../../http/request_response_general/error_message.dart';
import '../../../http/request_response_general/status.dart';
import '../../../requests/requests_url.dart';
import 'confirm_account_request.dart';

class ConfirmAccountRequestHttp extends ConfirmAccountRequest{

  ConfirmAccountRequestStatus _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return ConfirmAccountRequestStatus.ok;
    } else {
      return ConfirmAccountRequestStatus.error;
    }
  }

  ConfirmAccountRequestStatus _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessage error = ErrorMessage.fromJson(parsedResponse);

    if (error.errorMessage == "Bad code") {
      return ConfirmAccountRequestStatus.badCode;
    }else {
      return ConfirmAccountRequestStatus.error;
    }
  }



  @override
  Future<ConfirmAccountRequestStatus> confirmAccount(ConfirmAccountData confirmAccountData) async {
    var bodyConfirmAccountData = jsonEncode(confirmAccountData);

    var httpHelper = HttpHelper();
    try {
      var result = await httpHelper.executeHttpRequestWithTimeout(
        RequestsURL.confirmCodeCreateAccount,
        body: bodyConfirmAccountData,
      );

      if (result.statusCode == 200) {
        return _getCorrectResponseStatus(result.body);
      } else {
        return _getErrorResponseStatus(result.body);
      }
    } catch (e) {
      return ConfirmAccountRequestStatus.error;
    }
  }

}