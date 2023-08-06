import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/style/main_style.dart';

import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../common/input/input_code.dart';
import '../common/input/input_personal_data.dart';

class ConfirmCodeForm extends StatefulWidget {
  const ConfirmCodeForm({super.key});

  @override
  ConfirmCodeFormState createState() {
    return ConfirmCodeFormState();
  }
}

class ConfirmCodeFormState extends State<ConfirmCodeForm> {
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;

  bool isErrorLoginTry = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();

    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const NameApp(),
              ),
              SizedBox(height: breakBetweenNameAppAndForm),
              RichText(
                text: TextSpan(
                  text: 'We sent you an email with a 4-digit code. Enter it to create an account. ',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold, color: MainAppStyle.mainColorApp),
                        text: ' Resend code ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar( backgroundColor: MainAppStyle.mainColorApp,
                                content: Text("Send confirm code")));
                          }),
                  ],
                ),
              ),
              SizedBox( height:30),
              InputCode(usernameController),
              Text(
                isErrorLoginTry ? "incorrect login details" : "",
                style: const TextStyle(color: Colors.red),
              )
              ,

              MainActionButton(
                  text: 'Register',

                  action: () {
                    //When function has ()=>{} is one line //(){} is anonymus multiline

                    PageRouteNavigation.navigationTransitionSlideFromDown(
                        context: context, destination:  ConfirmRegisterCode()
                    );
                    if (_formKey.currentState!.validate()) {


                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("LOGGED")));
                    }else{
                      setState(() {
                        isErrorLoginTry = true;
                      });
                    }
                  }),
            ],
          )),
    );
  }
}
