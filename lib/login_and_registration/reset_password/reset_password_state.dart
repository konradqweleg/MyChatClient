import 'package:flutter/material.dart';
import '../../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ResetPasswordState {
  start(false,false,false,Colors.grey,MainAppStyle.mainColorApp,false,true,false),
  noExistsEmail(false,false,true,Colors.grey,MainAppStyle.mainColorApp,true,false,false),
  sendCode(true,true,false,MainAppStyle.mainColorApp,Colors.grey,true,true,false),
  badCode(true,true,false,MainAppStyle.mainColorApp,Colors.grey,true,true,true);


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

  String getMessageBadCode(BuildContext context){
    if(isBadCode){
      return AppLocalizations.of(context)!.errorCode;
    }else{
      return "";
    }
  }

   const ResetPasswordState(this.isActiveResendCode, this.isEnableEnterCode,
      this.isExistsEmailInService, this.colorResetPasswordButton,
      this.colorSendCodeButton, this.isResetPasswordButtonEnabled,
      this.isSendCodeButtonEnabled,this.isBadCode);

  final bool isActiveResendCode;
  final bool isEnableEnterCode;
  final bool isExistsEmailInService;
  final Color colorResetPasswordButton;
  final Color colorSendCodeButton;
  final bool isSendCodeButtonEnabled;
  final bool isResetPasswordButtonEnabled;
  final bool isBadCode;



}