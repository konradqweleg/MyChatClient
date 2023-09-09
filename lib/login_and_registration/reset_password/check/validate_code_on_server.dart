import 'package:my_chat_client/login_and_registration/reset_password/check/validate_code.dart';

class ValidateCodeOnServer implements ValidateCode{
  @override
  bool isValidCode(String code,String email) {
    return true;
  }

}