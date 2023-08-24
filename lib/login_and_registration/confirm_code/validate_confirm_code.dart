import 'package:my_chat_client/login_and_registration/confirm_code/create_account_data.dart';

abstract class ValidateConfirmCode{
  bool isValidConfirmCode(CreateAccountData createAccountData);
}