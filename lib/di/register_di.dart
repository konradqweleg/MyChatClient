import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/di_db/di_db_service.dart';
import 'package:my_chat_client/di/di_factory.dart';


import '../database/di_db/di_db_service_sqlite.dart';
import '../login_and_registration/login/di/login_di_register.dart';

class RegisterDI {

  final DiFactory _diFactory;

  RegisterDI(this._diFactory);


  void register() {
    _registerDatabaseService();
    _registerLoginDi(_diFactory);
  }

  void _registerLoginDi(DiFactory diFactory) {
    LoginDiRegister loginDiRegister = diFactory.getDiRegisterForLogin();
    loginDiRegister.register();
  }

  void _registerDatabaseService() {
    DiDbService diDbService = DiDbServiceSqlite();
    diDbService.register();
  }

}
