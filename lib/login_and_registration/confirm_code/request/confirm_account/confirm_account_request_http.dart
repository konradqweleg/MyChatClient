import 'dart:convert';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_data.dart';

import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_request_status.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/error_message.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';
import 'confirm_account_request.dart';
import 'package:http/http.dart' as http;

class ConfirmAccountRequestHttp extends ConfirmAccountRequest{

  Result _getCorrectResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    Status status = Status.fromJson(parsedResponse);
    if (status.correctResponse) {
      return Result.success(ConfirmAccountRequestStatus.ok);
    } else {
      return Result.error(ConfirmAccountRequestStatus.error);
    }
  }

  Result _getErrorResponseStatus(String resultBody) {
    Map parsedResponse = json.decode(resultBody);
    ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

    if (error.errorMessage == "Bad code") {
      return Result.error(ConfirmAccountRequestStatus.badCode);
    }else if (error.errorMessage == "Code not found for this user"){
      return Result.error( ConfirmAccountRequestStatus.noCodeForUser);
    }
    else
    {
      return Result.error(ConfirmAccountRequestStatus.error);
    }
  }



  @override
 Future<Result> confirmAccount(ConfirmAccountData confirmAccountData) async {
    var bodyConfirmAccountData = jsonEncode(confirmAccountData);

    var httpHelper = HttpHelper(http.Client());
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
      return Result.error(ConfirmAccountRequestStatus.error);
    }
  }

}