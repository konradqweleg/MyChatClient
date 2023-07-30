import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/main_action_button.dart';

import '../../main_app_resources/name_app.dart';
import '../common/input_personal_data.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: const NameApp(),
              ),
              SizedBox(height: breakBetweenNameAppAndForm),
              InputEmail(emailController),
              InputData(emailController,"Username"),
              InputData(emailController, "Surname"),
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
