import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input_mail.dart';
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

  bool isErrorLoginTry = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const NameApp(),
              ),
              SizedBox(height: breakBetweenNameAppAndForm),
              InputEmail(emailController),
              InputPassword(passwordController),
              const SizedBox(
                height: 10,
              ),
              Text(
                isErrorLoginTry ? "incorrect login details" : "",
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(
                  text: 'Login',
                  action: () {
                    //When function has ()=>{} is one line //(){} is anonymus multiline

                    if (_formKey.currentState!.validate()) {
                      String login = emailController.text;
                      String password = passwordController.text;
                      if (login == "polska699@interia.eu" && password == "qwerty") {

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("LOGGED")));


                      } else {
                        setState(() {
                          isErrorLoginTry = true;
                        });
                      }


                    }
                  }),
            ],
          )),
    );
  }
}
