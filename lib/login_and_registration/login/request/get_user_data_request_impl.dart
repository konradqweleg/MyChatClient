import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/user_data.dart';
import '../../../http/http_helper_auth.dart';
import '../../../requests/requests_url.dart';
import 'get_user_data_request.dart';

class GetUserDataRequestImpl extends GetUserDataRequest {

  final GetIt _getIt = GetIt.instance;

  GetUserDataRequestImpl(){
    httpHelperAuth = _getIt<HttpHelperAuth>();
  }

  HttpHelperAuth? httpHelperAuth ;

  @override
  Future<Result> _getUserDataByEmail(String email) async {
    Result userData = await httpHelperAuth!.get(RequestsURL.getUserDataByEmail+email);

    print(userData.data);

    if (userData.isSuccess()) {
      Map parsedResponse = json.decode(userData.data);
      return Result.success(UserData.fromJson(parsedResponse) );
    } else {
      return Result.error("Error getting user data");
    }
  }


  @override
  Future<Result> getUserDataWithEmail(EmailData loginData) {
    return _getUserDataByEmail(loginData.email);
  }

}
