
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

import '../../common/result.dart';

abstract class RegisterUserRequest{
  Future<Result> register(UserRegisterData userRegisterData);
}