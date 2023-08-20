//EmailValidate

import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/email_validate.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/validation_mail_state.dart';

void main() {
  group('unit_email_validator', () {
    testWidgets(
        'Expect empty email when input login is empty',
            (WidgetTester tester) async {
          //given
          EmailValidate validator = EmailValidate();

          ValidatedEmailState validateResult = validator.validate("");
          //then
          expect(ValidatedEmailState.emptyText, validateResult);
        });



  });
}
