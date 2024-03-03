import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_data/login_data.dart';


abstract class LoginRequest {
  Future<Result> login(LoginData loginData);
}