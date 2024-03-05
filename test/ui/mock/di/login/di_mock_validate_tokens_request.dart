import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';

import 'mock_saved_tokens_request/mock_di_factory_bad_saved_tokens.dart';
import 'mock_saved_tokens_request/mock_di_factory_correct_saved_tokens.dart';

class DiMockValidateTokensRequest{
  void registerMockDiRequestStayOnActualLoginPage() {
    RegisterDI registerDI = RegisterDI(MockDiFactoryImplBadSavedTokens());
    registerDI.register();
  }

  void registerMockDiRequestGoToMainConversationPage() {
    RegisterDI registerDI = RegisterDI(MockDiFactoryImplCorrectSavedTokens());
    registerDI.register();
  }




}