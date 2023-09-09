import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/reset_code.dart';
import '../../../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ResetCodeOnServer implements ResetCode{
  @override
  void sendCode(BuildContext context,String email) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              backgroundColor: MainAppStyle.mainColorApp,
              content: Text( AppLocalizations.of(context)!.sendPasswordResetCode,)));
  }

}