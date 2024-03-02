import 'package:flutter/material.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';

import 'package:my_chat_client/login_and_registration/login/request/login_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_error_status.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/Tokens.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';
import 'package:my_chat_client/tokens/token_manager.dart';


import '../../common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../navigation/page_route_navigation.dart';
import '../../tokens/saved_login_data.dart';
import '../../tokens/token_manager_factory.dart';
import '../common/button/main_action_button.dart';
import '../common/error_message.dart';
import '../common/errors.dart';
import '../common/result.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.loginRequest,super.key});
  final LoginRequest loginRequest;

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
  final Errors _matchedErrorToErrorMessageLoginRequest=
  Errors();


  void _initMatchedErrorToErrorMessage() {
    if (_matchedErrorToErrorMessageLoginRequest.isInit()) {
      _matchedErrorToErrorMessageLoginRequest
          .registerMatchErrorToResultStatus(ErrorMessage.error(
          AppLocalizations.of(context)!
              .errorRequestInformationOnInternetAccessCheck,
          Result.error(LoginRequestErrorStatus.error)));

      _matchedErrorToErrorMessageLoginRequest
          .registerMatchErrorToResultStatus(ErrorMessage.error(
          AppLocalizations.of(context)!.badLoginCredentials,
          Result.error(LoginRequestErrorStatus.badCredentials)));

    }
  }


  Text _getErrorMessageWhenErrorInTryLogin() {
   if(_matchedErrorToErrorMessageLoginRequest.isError()){

     return Text(_matchedErrorToErrorMessageLoginRequest.getErrorMessage(),style: const TextStyle(color: Colors.red));
   }else{
     return const Text("");
   }
  }





  bool _validateLoginData() {
    return _loginFormKey.currentState!.validate();
  }

  Future<void> setUserLoginFlag() async {
    SavedLoginData.setUserLoginFlag();
  }


  void _logIn() {

    setUserLoginFlag();

    PageRouteNavigation.navigation(
      context: context,
      destination: const MainConversationList(),
      isClearBackStack: true,
    );
  }

  void _checkLoginData() async {


    setState(() {
      _matchedErrorToErrorMessageLoginRequest.clearError();
    });

    bool isPassValidationLoginData = _validateLoginData();
    if (!isPassValidationLoginData) {
      return;
    }

    LoginData loginData = LoginData(
        email: emailController.text, password: passwordController.text);

    Future<Result> requestLoginResult = widget.loginRequest.login(loginData);

    requestLoginResult.then((value) {
      Result resultLoginRequest = value;

      if (resultLoginRequest.isSuccess()) {
        _saveUserLoginAuth(resultLoginRequest);
        _logIn();
      } else if (resultLoginRequest.isError()) {

        _initMatchedErrorToErrorMessage();
        setState(() {
          _matchedErrorToErrorMessageLoginRequest
              .setActualError(resultLoginRequest);

        });
      }
    });


  }

  void _saveUserLoginAuth(Result resultLoginRequest) async {

     Tokens tokens = resultLoginRequest.getData() as Tokens;

     TokenManager tokenManager = TokenManagerFactory.getTokenManager();
     tokenManager.saveAccessToken(tokens.accessToken);
     tokenManager.saveRefreshToken(tokens.refreshToken);


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
              _getErrorMessageWhenErrorInTryLogin(),
              MainActionButton(
                  text: AppLocalizations.of(context)!.login,
                  action: _checkLoginData),
            ],
          )),
    );
  }
}
