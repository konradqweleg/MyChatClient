import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_data.dart';


import '../../common/result.dart';

abstract class ConfirmAccountRequest{
  Future<Result>  confirmAccount(ConfirmAccountData confirmAccountData);
}