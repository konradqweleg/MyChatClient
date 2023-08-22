import 'package:my_chat_client/login_and_registration/common/input/validator/validate_input_code_state.dart';

class InputCodeValidate {
  static const int codeCorrectLength = 4;

  ValidatedInputCodeState validate(String? text) {
    if (text == null || text.isEmpty) {
      return ValidatedInputCodeState.emptyText;
    } else if (text.length < codeCorrectLength) {
      return ValidatedInputCodeState.notEnoughDigits;
    }

    return ValidatedInputCodeState.ok;
  }
}
