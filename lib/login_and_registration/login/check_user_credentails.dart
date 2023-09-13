
import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';

class CheckUserCredentials implements CheckCredentials{

  @override
  bool isValidCredentials(String email, String password) {
    if (email == "example@mail.pl" && password == "password123") {
      return true;
    }
    return false;
  }

}