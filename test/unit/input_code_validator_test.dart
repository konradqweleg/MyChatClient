
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/input_code_validate.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/validate_input_code_state.dart';

void main() {
  group('unit_input_code_validator', () {
    test('Expect empty data state when input is empty', () async {
      //given
      InputCodeValidate validator = InputCodeValidate();

      ValidatedInputCodeState validateResult = validator.validate("");
      //then
      expect(ValidatedInputCodeState.emptyText, validateResult);
    });

    test('Expect not enough digit input state when user introduce less than 4 digits', () async {
      //given
      InputCodeValidate validator = InputCodeValidate();

      ValidatedInputCodeState validateResult = validator.validate("999");
      //then
      expect(ValidatedInputCodeState.notEnoughDigits, validateResult);
    });

    test('Expect correct input state when user introduce 4 digits', () async {
      //given
      InputCodeValidate validator = InputCodeValidate();

      ValidatedInputCodeState validateResult = validator.validate("9999");
      //then
      expect(ValidatedInputCodeState.ok, validateResult);
    });


  });
}