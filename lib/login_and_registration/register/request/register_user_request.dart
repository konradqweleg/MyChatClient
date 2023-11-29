import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

abstract class RegisterUserRequest{
  Future<bool> register(UserRegisterData userRegisterData);
}