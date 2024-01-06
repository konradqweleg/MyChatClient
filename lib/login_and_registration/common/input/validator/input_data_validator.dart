import 'package:my_chat_client/login_and_registration/common/input/validator/validated_data_state.dart';

class InputDataValidate {
  static const int _minLengthText = 2;

  ValidatedInputState validate(String? text) {
    if (text == null || text.isEmpty) {
      return ValidatedInputState.emptyText;
    } else if (text.length < _minLengthText) {
      return ValidatedInputState.tooShort;
    }
    return ValidatedInputState.ok;
  }
}
