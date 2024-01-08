import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import '../../../common/result.dart';

abstract class ResendConfirmAccountCodeRequest{
  Future<Result>  resendActiveAccountCode(EmailData emailData);
}