import 'package:my_chat_client/login_and_registration/common/input/validator/validation_password_state.dart';

class PasswordValidate {
  ValidatedPasswordState validate(String? password) {
    if (password == null || password.isEmpty) {
      return ValidatedPasswordState.emptyText;
    }
    return ValidatedPasswordState.ok;
  }
}
