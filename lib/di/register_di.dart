import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/di_db/di_db_service.dart';
import 'package:my_chat_client/di/di_factory.dart';
import 'package:my_chat_client/http/di/di_http_request_register.dart';


import '../database/di_db/di_db_service_sqlite.dart';
import '../login_and_registration/login/di/login_di_register.dart';

class RegisterDI {

  final DiFactory _diFactory;

  RegisterDI(this._diFactory);


  void register() {
    _registerDatabaseService();
    _registerAuthHttRequest(_diFactory);
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

  void _registerAuthHttRequest(DiFactory diFactory){
    DiHttpRequestRegister diHttpRequestRegister = diFactory.getDiRegisterForHttpRequest();
    diHttpRequestRegister.register();
  }

}
