import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/other_form_login/login_with_google_or_facebook.dart';
import '../../style/main_style.dart';
import 'login_form.dart';

void main() => runApp(const Login());

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {

    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              child: Padding(
                padding:  MainAppStyle.defaultMainPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Container(
                      // Another fixed-height child.
                      height: 400.0,
                      alignment: Alignment.center,
                      child: const LoginForm(),
                    ),
                    const SizedBox(height: 30),
                    const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CreateNewAccountButton(),
                          ResetPasswordButton(),
                        ]),
                    const SizedBox(height: 20),
                    const LoginWithGoogleOrFacebook()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


