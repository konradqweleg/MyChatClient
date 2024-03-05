

import '../http/di/di_http_request_register.dart';
import '../login_and_registration/login/di/login_di_register.dart';

abstract class DiFactory{
  LoginDiRegister getDiRegisterForLogin();
  DiHttpRequestRegister getDiRegisterForHttpRequest();

}