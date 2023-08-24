import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

class CreateAccountData{
  UserRegisterData userRegisterData;
  String confirmCode;

  CreateAccountData(this.userRegisterData,this.confirmCode);
}