import 'package:flutter/material.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';
import '../../common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/page_route_navigation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.checkCredentials,super.key});
  final CheckCredentials checkCredentials;

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;
  bool isErrorWhenTryToLogIn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _setErrorLoginDataState() {
    setState(() {
      isErrorWhenTryToLogIn = true;
    });
  }

  String _getErrorMessageWhenErrorInTryLogin() {
    String noError = "";
    return isErrorWhenTryToLogIn
        ? AppLocalizations.of(context)!.incorrectLoginDetails
        : noError;
  }

  bool _validateLoginData() {
    return _loginFormKey.currentState!.validate();
  }


  // bool _checkLoginCredentialsOnServer(String email, String password) {
  //   if (email == "polska699@interia.eu" && password == "qwerty") {
  //     return true;
  //   }
  //   return false;
  // }

  void _logIn() {
    PageRouteNavigation.navigation(
      context: context,
      destination: const Conversation(),
      isClearBackStack: true,
    );
  }

  void _checkLoginData() {
    bool isPassValidationLoginData = _validateLoginData();

    if (!isPassValidationLoginData) {
      return;
    }

    bool isTheCorrectLoginCredentials =
        widget.checkCredentials.isValidCredentials(emailController.text, passwordController.text);

    if (isTheCorrectLoginCredentials) {
      _logIn();
    } else {
      _setErrorLoginDataState();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _loginFormKey,
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
                _getErrorMessageWhenErrorInTryLogin(),
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(
                  text: AppLocalizations.of(context)!.login,
                  action: _checkLoginData),
            ],
          )),
    );
  }
}
