import '../../../common/result.dart';
import '../../../confirm_code/request/resend_active_account_code/email_data.dart';

abstract class CheckExistsEmailRequest {
  Future<Result> isEmailExistsInService(EmailData email);
}