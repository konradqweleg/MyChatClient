import 'dart:convert';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/change_password_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password_status.dart';

import '../../../../http/http_helper.dart';
import '../../../../http/request_response_general/error_message.dart';
import '../../../../http/request_response_general/status.dart';
import '../../../../requests/requests_url.dart';

import 'package:http/http.dart' as http;
class RequestChangePasswordHttp extends RequestChangePassword {

  Result _getCorrectResponseStatus(String resultBody) {
  Map parsedResponse = json.decode(resultBody);
  Status status = Status.fromJson(parsedResponse);
  if (status.correctResponse) {
    return Result.success(RequestChangePasswordStatus.ok);
  } else {
    return Result.error(RequestChangePasswordStatus.error);
  }

}

Result _getErrorResponseStatus(String resultBody) {
  Map parsedResponse = json.decode(resultBody);
  ErrorMessageData error = ErrorMessageData.fromJson(parsedResponse);

  if (error.errorMessage == "Bad change password code") {
    return Result.error(RequestChangePasswordStatus.badChangePasswordCode);
  }else if (error.errorMessage == "User or reset password code not found"){
    return Result.error( RequestChangePasswordStatus.resetPasswordCodeNotFoundForThisUser);
  }
  else
  {
    return Result.error(RequestChangePasswordStatus.error);
  }
}


  @override
  Future<Result> requestChangePassword(ChangePasswordData changePasswordData) async {
  var bodyChangePasswordData = jsonEncode(changePasswordData);

  var httpHelper = HttpHelper(http.Client());
  try {
    var result = await httpHelper.executeHttpRequestWithTimeout(
      RequestsURL.changePassword,
      body: bodyChangePasswordData,
    );

    if (result.statusCode == 200) {
      return _getCorrectResponseStatus(result.body);
    } else {
      return _getErrorResponseStatus(result.body);
    }

  } catch (e) {
    return Result.error(RequestChangePasswordStatus.error);
  }


  }



}

