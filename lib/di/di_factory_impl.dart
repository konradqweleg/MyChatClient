
import '../login_and_registration/login/di/login_di_register.dart';
import '../login_and_registration/login/di/login_di_register_impl.dart';
import 'di_factory.dart';

class DiFactoryImpl implements DiFactory {

  @override
  LoginDiRegister getDiRegisterForLogin() {
    return LoginDiRegisterImpl();
  }

}