import 'package:my_chat_client/login_and_registration/common/input/validator/validation_mail_state.dart';
import 'package:email_validator/email_validator.dart';

class EmailValidate {
  ValidatedEmailState validate(String? email) {
    if (email == null || email.isEmpty) {
      return ValidatedEmailState.emptyText;
    } else if (!EmailValidator.validate(email)) {
      return ValidatedEmailState.badFormat;
    }
    return ValidatedEmailState.ok;
  }

}
