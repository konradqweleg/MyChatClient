// import 'package:my_chat_client/login_and_registration/confirm_code/create_account_data.dart';
// import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_data.dart';
// import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request.dart';
// import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request_http.dart';
// import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request_status.dart';
// import 'package:my_chat_client/login_and_registration/confirm_code/validate_confirm_code.dart';
//
// class ValidateConfirmCodeOnServer implements ValidateConfirmCode {
//   final ConfirmAccountRequest _confirmAccountRequest =
//       ConfirmAccountRequestHttp();
//
//   @override
//   Future<bool> isValidConfirmCode(ConfirmAccountData createAccountData) async {
//     ConfirmAccountRequestStatus confirmAccountRequestStatus =
//         await _confirmAccountRequest.confirmAccount(createAccountData);
//
//     if (confirmAccountRequestStatus == ConfirmAccountRequestStatus.ok) {
//       return true;
//     } else {
//       return false;
//     }
//
//   }
// }
