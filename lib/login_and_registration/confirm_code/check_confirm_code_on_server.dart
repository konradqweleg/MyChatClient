import 'package:my_chat_client/login_and_registration/confirm_code/create_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/validate_confirm_code.dart';

class ValidateConfirmCodeOnServer implements ValidateConfirmCode {

  @override
  bool isValidConfirmCode(CreateAccountData createAccountData){
    return true;
  }

}