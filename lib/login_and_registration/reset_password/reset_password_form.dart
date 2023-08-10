import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../../style/main_style.dart';
import '../common/input/input_code.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  ResetPasswordFormState createState() {
    return ResetPasswordFormState();
  }
}

class ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKeyMail = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;

  bool isEmailExistsOnServer = false;
  bool isSendEmail = false;
  bool isSendCode = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isValidFormatEmail() {
    if (!_formKeyMail.currentState!.validate()) {
      return false;
    }
    return true;
  }

  bool isEmailExistOnServer(){
    return emailController!.text == "polska699@interia.eu";
  }

  void goToVerficationCode(){
    setState(() {
      isSendCode = true;
    });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: MainAppStyle.mainColorApp,
          content: Text(AppLocalizations.of(context)!.passwordResetCodeSend)));

    //PageRouteNavigation.navigation(context: context, destination: NewPassword());
  }

  void sendResetPasswordCode(){
    bool isValidFormatMail = _isValidFormatEmail();

    if(!isValidFormatMail){
      return;
    }

    if(!isEmailExistOnServer()){
      isEmailExistsOnServer = true;
    }else{
     goToVerficationCode();
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: const NameApp(),
        ),
        SizedBox(height: breakBetweenNameAppAndForm),
        Text.rich(TextSpan(
            text: AppLocalizations.of(context)!
                .descriptionSendMailWithResetPasswordCode,
            children: <InlineSpan>[
               TextSpan(
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MainAppStyle.mainColorApp),
                  text: isSendCode ?   AppLocalizations.of(context)!.resendCode : "",
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ])),
        Form(key: _formKeyMail, child: InputEmail(emailController)),
        Text(isEmailExistsOnServer ?  AppLocalizations.of(context)!.noUserWithThisEmail: "",style: TextStyle(color: Colors.red),),
        MainActionButton(
            text:AppLocalizations.of(context)!.sendResetPasswordCode,
            action: isSendCode ? null : sendResetPasswordCode,
            backgroundColor:
        isSendCode ? Colors.grey : MainAppStyle.mainColorApp
            //     () {
            //   //When function has ()=>{} is one line //(){} is anonymus multiline
            //
            //   if (_formKeyMail.currentState!.validate()) {}
            //
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       backgroundColor: MainAppStyle.mainColorApp,
            //       content: Text("Send reset password code")));
            //
            //   setState(() {
            //     isSendEmail = true;
            //   });
            // }

            ),
        SizedBox(height: 15),
        const Text(
          "Enter the code\n received in the email",
          textAlign: TextAlign.center,
        ),
        InputCode(passwordController),
        const SizedBox(
          height: 10,
        ),
        Text(
          isEmailExistsOnServer ? "incorrect login details" : "",
          style: const TextStyle(color: Colors.red),
        ),
        MainActionButton(
            text: 'Reset password',
            backgroundColor:
                !isSendEmail ? Colors.grey : MainAppStyle.mainColorApp,
            action: () {
              PageRouteNavigation.navigationTransitionSlideFromDown(
                context: context,
                destination: const NewPassword(),
              );
            }),
      ],
    ));
  }
}
