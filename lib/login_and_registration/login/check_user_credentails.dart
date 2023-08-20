import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';

class CheckUserCredentials implements CheckCredentials{

  @override
  bool isValidCredentials(String email, String password) {
    if (email == "polska699@interia.eu" && password == "qwerty") {
      return true;
    }
    return false;
  }

}