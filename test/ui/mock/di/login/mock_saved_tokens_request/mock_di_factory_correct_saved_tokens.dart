import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/login_and_registration/login/di/login_di_register.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';

class MockIsCorrectSavedTokensCorrectTokens implements RequestIsCorrectTokens {
  @override
  Future<bool> isCorrectSavedTokens() {
    return Future.value(true);
  }
}

class MockLoginDiRegisterCorrectSavedTokens implements LoginDiRegister {
  static final GetIt _getIt = GetIt.instance;

  @override
  void register() {
    _registerRequests();
  }

  void _registerRequests(){
    _getIt.registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensCorrectTokens());
  }
}

class MockDiFactoryImplCorrectSavedTokens implements DiFactoryImpl {

  @override
  LoginDiRegister getDiRegisterForLogin() {
    return MockLoginDiRegisterCorrectSavedTokens();
  }

}