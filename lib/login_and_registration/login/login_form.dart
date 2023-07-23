import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input_login.dart';
import 'package:my_chat_client/login_and_registration/common/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/main_action_button.dart';

import '../../main_app_resources/name_app.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;

  @override
  Widget build(BuildContext context) {
    //return Placeholder();
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child:  const NameApp(),
              ),
              SizedBox(height: breakBetweenNameAppAndForm),
              const InputLogin(),
              const InputPassword(),
              const SizedBox(height: 10,),
              MainActionButton(text: 'Login', action: ()=>{}),

            ],
          )),
    );
  }
}