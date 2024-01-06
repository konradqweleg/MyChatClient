import 'package:my_chat_client/login_and_registration/common/input/validator/validation_password_state.dart';

class PasswordValidate {
  static const int _minLengthPassword = 6;

  ValidatedPasswordState validate(String? password) {
    if (password == null || password.isEmpty) {
      return ValidatedPasswordState.emptyText;
    }else if(password.length < _minLengthPassword){
      return ValidatedPasswordState.tooShort;
    }
    return ValidatedPasswordState.ok;
  }
}
