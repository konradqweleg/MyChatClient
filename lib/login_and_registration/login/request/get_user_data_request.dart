import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/user_data.dart';
import '../../common/result.dart';

abstract class GetUserDataRequest{
  Future<Result> getUserDataWithEmail(EmailData loginData);
}