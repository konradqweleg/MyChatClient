import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/create_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request.dart';
import 'package:my_chat_client/style/main_style.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../common/input/input_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../register/user_register_data.dart';




class LocalizationsInject extends StatelessWidget {
  final Widget child;
  const LocalizationsInject({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      home: child,
    );
  }
}

//
// void main() => runApp(
//     LocalizationsInject(child:
//     ConfirmCodeRegisterForm(UserRegisterData("","","",""),ValidateConfirmCodeOnServer())));


class ConfirmCodeRegisterForm extends StatefulWidget {
  const ConfirmCodeRegisterForm( this.userRegisterData,this.checkConfirmCodeRequest, {super.key});
  final UserRegisterData userRegisterData;
  final ConfirmAccountRequest checkConfirmCodeRequest;

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
    CreateAccountData createAccountData = CreateAccountData(widget.userRegisterData, controller.text);
    bool isCreatedAccount =  widget.checkConfirmCodeRequest.isValidConfirmCode(createAccountData);
    return isCreatedAccount;
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
