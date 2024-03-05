
import 'package:my_chat_client/http/di/di_http_request_register.dart';

import '../http/di/di_http_request_register_impl.dart';
import '../login_and_registration/login/di/login_di_register.dart';
import '../login_and_registration/login/di/login_di_register_impl.dart';
import 'di_factory.dart';

class DiFactoryImpl implements DiFactory {

  @override
  LoginDiRegister getDiRegisterForLogin() {
    return LoginDiRegisterImpl();
  }

  @override
  DiHttpRequestRegister getDiRegisterForHttpRequest() {
    return DiHttpRequestRegisterImpl();
  }

}