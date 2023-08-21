import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/password_validate.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/validation_password_state.dart';

void main() {
  group('unit_password_validator', () {
    test('Expect empty password state when password is empty', () async {
      //given
      PasswordValidate validator = PasswordValidate();

      ValidatedPasswordState validateResult = validator.validate("");
      //then
      expect(ValidatedPasswordState.emptyText, validateResult);
    });

    test('Expect correct password state when password has text', () async {
      //given
      PasswordValidate validator = PasswordValidate();

      ValidatedPasswordState validateResult = validator.validate("password");
      //then
      expect(ValidatedPasswordState.ok, validateResult);
    });


  });
}