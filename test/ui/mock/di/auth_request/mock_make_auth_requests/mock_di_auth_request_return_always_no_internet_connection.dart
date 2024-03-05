

import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/http/di/di_http_request_register.dart';
import 'package:my_chat_client/http/http_helper_auth.dart';
import 'package:my_chat_client/http/request_status/auth_request_status.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/login/di/login_di_register.dart';

import '../../login/mock_saved_tokens_request/mock_di_factory_correct_saved_tokens.dart';


class MockDiFactoryImplNoInternetConnection extends HttpHelperAuth{


  @override
  Future<Result> get(String url) async{
    return Result.error(AuthRequestStatus.redirectToLoginPage);
  }

  @override
  Future<Result> delete(String url, body) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result> post(String url, body) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Result> put(String url, body) {
    // TODO: implement put
    throw UnimplementedError();
  }




}


class MockRegisterDiHttpAuthReturnAlwaysNoInternetConnection extends DiHttpRequestRegister{
  static final GetIt _getIt = GetIt.instance;
  @override
  void register() {
    _getIt.registerSingleton<HttpHelperAuth>(MockDiFactoryImplNoInternetConnection());
  }

}

class MockDiFactoryRedirectToLoginPage extends DiFactoryImpl {

  @override
  DiHttpRequestRegister getDiRegisterForHttpRequest() {
    return MockRegisterDiHttpAuthReturnAlwaysNoInternetConnection();
  }


}