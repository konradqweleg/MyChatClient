
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/style/main_style.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../common/input/input_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmCodeRegisterForm extends StatefulWidget {
  const ConfirmCodeRegisterForm({super.key});

  @override
  State<ConfirmCodeRegisterForm> createState() {
    return _ConfirmCodeRegisterFormState();
  }
}

class _ConfirmCodeRegisterFormState extends State<ConfirmCodeRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;
  TextEditingController controller = TextEditingController();

  bool isErrorLoginTry = false;

  void _resendConfirmCode() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: MainAppStyle.mainColorApp,
        content: Text(AppLocalizations.of(context)!.sendConfirmCode)));
  }

  String _getInformationIsValidCode() {
    const String validCode = "";
    return isErrorLoginTry
        ? AppLocalizations.of(context)!.errorConfirmCode
        : validCode;
  }

  bool _isValidFormatCode() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void _showErrorWrongFormatCode() {
    setState(
      () {
        isErrorLoginTry = true;
      },
    );
  }

  bool _isCorrectCodeOnServer() {
    return controller.text == "0000";
  }

  void _logIn() {
    PageRouteNavigation.navigationTransitionSlideFromDown(
        context: context, destination: const Conversation());
  }

  void _checkIsCorrectCode() {
    bool isValidFormat = _isValidFormatCode();
    if (!isValidFormat) {
      return;
    }

    bool isCorrectCode = _isCorrectCodeOnServer();

    if (isCorrectCode) {
      _logIn();
    } else {
      _showErrorWrongFormatCode();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  text: AppLocalizations.of(context)!
                      .informUserAboutSendCodeOnMail,
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MainAppStyle.mainColorApp),
                        text: AppLocalizations.of(context)!.resendCode,
                        recognizer: TapGestureRecognizer()
                          ..onTap = _resendConfirmCode),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              InputCode(controller),
              Text(
                _getInformationIsValidCode(),
                style: const TextStyle(color: Colors.red),
              ),
              MainActionButton(
                  text: AppLocalizations.of(context)!.registerButtonText,
                  action: _checkIsCorrectCode),
            ],
          )),
    );
  }
}
