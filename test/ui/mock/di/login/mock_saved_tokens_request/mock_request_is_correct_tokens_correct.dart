
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
class MockRequestIsCorrectSavedTokensCorrectTokens implements RequestIsCorrectTokens {
  @override
  Future<bool> isCorrectSavedTokens() {
    return Future.value(true);
  }
}

