import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/input_data_validator.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/validated_data_state.dart';

void main() {
  group('unit_input_data_validator', () {
    test('Expect empty data state when input is empty', () async {
      //given
      InputDataValidate validator = InputDataValidate();

      ValidatedInputState validateResult = validator.validate("");
      //then
      expect(ValidatedInputState.emptyText, validateResult);
    });

    test('Expect correct input state when input has text', () async {
      //given
      InputDataValidate validator = InputDataValidate();

      ValidatedInputState validateResult = validator.validate("text");
      //then
      expect(ValidatedInputState.ok, validateResult);
    });


  });
}