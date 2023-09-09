import 'package:my_chat_client/login_and_registration/reset_password/check/checkExsistsEmail.dart';

class CheckEmailExistsOnServer implements CheckExistsEmail{
  @override
  bool isEmailExistsInService(String email) {
    return true;
  }

}