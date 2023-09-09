import 'dart:ui';

import 'package:flutter/material.dart';

import '../../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ResetPasswordState {
  start(false,false,false,Colors.grey,MainAppStyle.mainColorApp,false,true),
  noExistsEmail(false,false,true,Colors.grey,MainAppStyle.mainColorApp,true,false),
  sendCode(true,true,false,MainAppStyle.mainColorApp,Colors.grey,false,true);


  String getNoExistsEmailText(BuildContext context){
    if(isExistsEmailInService){
      return AppLocalizations.of(context)!.noUserWithThisEmail;
    }else{
      return "";
    }
  }

  String getResendCodeText(BuildContext context){
    if(isActiveResendCode){
      return AppLocalizations.of(context)!.resendCode;
    }else{
      return "";
    }
  }

   const ResetPasswordState(this.isActiveResendCode, this.isEnableEnterCode,
      this.isExistsEmailInService, this.colorResetPasswordButton,
      this.colorSendCodeButton, this.isResetPasswordButtonEnabled,
      this.isSendCodeButtonEnabled);

  final bool isActiveResendCode;
  final bool isEnableEnterCode;
  final bool isExistsEmailInService;
  final Color colorResetPasswordButton;
  final Color colorSendCodeButton;
  final bool isSendCodeButtonEnabled;
  final bool isResetPasswordButtonEnabled;


}