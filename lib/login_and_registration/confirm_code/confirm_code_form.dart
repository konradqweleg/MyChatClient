import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';

import '../../animations/PageRouteTransition.dart';
import '../../main_app_resources/name_app.dart';
import '../common/input_code.dart';
import '../common/input_personal_data.dart';

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
              InputCode(usernameController),

              Text(
                isErrorLoginTry ? "incorrect login details" : "",
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(text: "Resend code", action: (){

              },backgroudColor: Colors.orange,pressBackgroundColor: Colors.deepOrange,)

              ,
              MainActionButton(
                  text: 'Register',
                  action: () {
                    //When function has ()=>{} is one line //(){} is anonymus multiline

                    PageRouteTransition.transitionAfterDelay(
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
