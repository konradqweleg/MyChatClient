import 'package:get_it/get_it.dart';

import '../http_helper_auth.dart';
import '../http_helper_factory.dart';
import 'di_http_request_register.dart';

class DiHttpRequestRegisterImpl extends DiHttpRequestRegister {

  static final GetIt _getIt = GetIt.instance;

  @override
  void register() {
    _registerAuthHttRequest();
  }

  void _registerAuthHttRequest(){
    _getIt.registerSingleton<HttpHelperAuth>(HttpHelperFactory.createHttpHelperAuth());
  }

}