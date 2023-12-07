import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

abstract class RegisterUserRequest{
  Future<RegisterResponseStatus> register(UserRegisterData userRegisterData);
}