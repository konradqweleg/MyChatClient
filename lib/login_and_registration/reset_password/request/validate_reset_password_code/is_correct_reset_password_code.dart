import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/email_and_code_data.dart';

import '../../../common/result.dart';

abstract class IsCorrectResetPasswordCode{
  Future<Result> isCorrectResetPasswordCode(EmailAndCodeData emailAndCodeData);
}