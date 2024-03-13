import 'package:get_it/get_it.dart';



import '../request/get_user_data_request.dart';
import '../request/get_user_data_request_impl.dart';
import '../request/request_is_correct_tokens.dart';
import '../request/request_is_correct_tokens_http.dart';
import 'login_di_register.dart';

class LoginDiRegisterImpl extends LoginDiRegister {
  static final GetIt _getIt = GetIt.instance;

  @override
  void register() {
    _registerRequests();
  }

  void _registerRequests(){
    _getIt.registerSingleton<RequestIsCorrectTokens>(RequestIsCorrectTokensHttp());
    _getIt.registerSingleton<GetUserDataRequest>(GetUserDataRequestImpl());
  }



}
