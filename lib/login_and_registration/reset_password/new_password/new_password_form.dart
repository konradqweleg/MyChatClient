import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import '../../../common/name_app.dart';
import '../../../style/main_style.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

  @override
  State<NewPasswordForm> createState() {
    return _NewPasswordFormState();
  }
}

class _NewPasswordFormState extends State<NewPasswordForm> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: const NameApp(),
            ),
            SizedBox(height: breakBetweenNameAppAndForm),
            Text("Enter a new password"),
            Form(key : _formKey,child:
            InputPassword(emailController)),
            InputPassword(emailController),
            MainActionButton(
                text: 'Reset password',
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
          ],
        ));

  }
}
