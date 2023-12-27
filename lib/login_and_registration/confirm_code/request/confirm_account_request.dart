import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request_status.dart';

abstract class ConfirmAccountRequest{
  Future<ConfirmAccountRequestStatus> confirmAccount(ConfirmAccountData confirmAccountData);
}