//EmailValidate

import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/email_validate.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/validation_mail_state.dart';

void main() {
  group('unit_email_validator', () {
    test('Expect empty email state when email is empty', () async {
      //given
      EmailValidate validator = EmailValidate();

      ValidatedEmailState validateResult = validator.validate("");
      //then
      expect(ValidatedEmailState.emptyText, validateResult);
    });

    test('Expect incorrect format  email state when email is in bad format',
        () async {
      //given
      EmailValidate validator = EmailValidate();

      ValidatedEmailState validateResult =
          validator.validate("bad.mail.format");
      //then
      expect(ValidatedEmailState.badFormat, validateResult);
    });

    test('Expect correct format  email state when email is in correct format',
        () async {
      //given
      EmailValidate validator = EmailValidate();

      ValidatedEmailState validateResult =
          validator.validate("example@mail.pl");
      //then
      expect(ValidatedEmailState.ok, validateResult);
    });
  });
}
