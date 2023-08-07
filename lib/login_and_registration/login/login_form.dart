import 'package:flutter/material.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import '../../common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../navigation/page_route_navigation.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;
  bool isErrorWhenTryToLogIn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setErrorLoginDataState() {
    setState(() {
      isErrorWhenTryToLogIn = true;
    });
  }

  String getErrorMessageWhenErrorInTryLogin() {
    String noError = "";
    return isErrorWhenTryToLogIn
        ? AppLocalizations.of(context)!.incorrectLoginDetails
        : noError;
  }

  bool validateLoginData() {
    return _loginFormKey.currentState!.validate();
  }


  bool checkLoginCredentialsOnServer(String email, String password) {
    if (email == "polska699@interia.eu" && password == "qwerty") {
      return true;
    }
    return false;
  }

  void logIn() {
    PageRouteNavigation.navigation(
      context: context,
      destination: const Conversation(),
      isClearBackStack: true,
    );
  }

  void checkLoginData() {
    bool isPassValidationLoginData = validateLoginData();
    if (!isPassValidationLoginData) {
      return;
    }

    bool isTheCorrectLoginCredentials =
        checkLoginCredentialsOnServer(emailController.text, passwordController.text);
    if (isTheCorrectLoginCredentials) {
      logIn();
    } else {
      setErrorLoginDataState();
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
                getErrorMessageWhenErrorInTryLogin(),
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(
                  text: AppLocalizations.of(context)!.login,
                  action: checkLoginData),
            ],
          )),
    );
  }
}
