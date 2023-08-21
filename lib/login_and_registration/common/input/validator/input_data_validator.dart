
import 'package:my_chat_client/login_and_registration/common/input/validator/validated_data_state.dart';

class InputDataValidate{
  ValidatedInputState validate(String? text) {
    if (text == null || text.isEmpty) {
      return ValidatedInputState.emptyText;
    }
    return ValidatedInputState.ok;
  }
}