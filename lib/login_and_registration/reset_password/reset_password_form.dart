import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';

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
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;

  bool isErrorLoginTry = false;
  bool isSendEmail =false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
           body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const NameApp(),
              ),
              SizedBox(height: breakBetweenNameAppAndForm),
              Text("Enter the email address of the account for which you want to reset the password"),

               Form(key : _formKey,child:
               InputEmail(emailController)),
              MainActionButton(
                  text: !isSendEmail ? 'Send mail' : 'Resend mail',
                  action: () {
                    //When function has ()=>{} is one line //(){} is anonymus multiline

                    if (_formKey.currentState!.validate()) {
                    }

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar( backgroundColor: MainAppStyle.mainColorApp,
                        content: Text("Send reset password code")));

                    setState(() {
                      isSendEmail = true;
                    });



                  }),
              SizedBox(height: 15),
              const Text(
                "Enter the code\n received in the email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                textAlign: TextAlign.center,
              ),
              InputCode(passwordController),
              const SizedBox(
                height: 10,
              ),
              Text(
                isErrorLoginTry ? "incorrect login details" : "",
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(
                  text: 'Reset password',
                  backgroundColor:  !isSendEmail ? Colors.grey : MainAppStyle.mainColorApp,
                  action: (){
                    PageRouteNavigation.navigationTransitionSlideFromDown(
                      context: context,
                      destination: const NewPassword(),
                    );
                  }),
            ],
          ));

  }
}
