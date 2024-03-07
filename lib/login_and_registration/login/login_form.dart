import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';

import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/login/request/get_user_data_request.dart';

import 'package:my_chat_client/login_and_registration/login/request/login_request.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_error_status.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_data/login_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/tokens_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/user_data.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';
import 'package:my_chat_client/tokens/token_manager.dart';

import '../../common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../database/model/info_about_me.dart';
import '../../navigation/page_route_navigation.dart';
import '../../style/main_style.dart';
import '../../tokens/saved_login_data.dart';
import '../../tokens/token_manager_factory.dart';
import '../common/button/main_action_button.dart';
import '../common/error_message.dart';
import '../common/errors.dart';
import '../common/result.dart';
import '../confirm_code/request/resend_active_account_code/email_data.dart';
import 'login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.loginRequest, super.key});

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
  final Errors _matchedErrorToErrorMessageLoginRequest = Errors();
  static final GetIt _getIt = GetIt.instance;

  void _initMatchedErrorToErrorMessage() {
    if (_matchedErrorToErrorMessageLoginRequest.isInit()) {
      _matchedErrorToErrorMessageLoginRequest.registerMatchErrorToResultStatus(
          ErrorMessage.error(
              AppLocalizations.of(context)!
                  .errorRequestInformationOnInternetAccessCheck,
              Result.error(LoginRequestErrorStatus.error)));

      _matchedErrorToErrorMessageLoginRequest.registerMatchErrorToResultStatus(
          ErrorMessage.error(AppLocalizations.of(context)!.badLoginCredentials,
              Result.error(LoginRequestErrorStatus.badCredentials)));
    }
  }

  Text _getErrorMessageWhenErrorInTryLogin() {
    if (_matchedErrorToErrorMessageLoginRequest.isError()) {
      return Text(_matchedErrorToErrorMessageLoginRequest.getErrorMessage(),
          style: const TextStyle(color: Colors.red));
    } else {
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
        _saveUserDataInDb(emailController.text);
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

  Future<void> _saveUserDataInDb(String userEmail) async {
    bool isAlreadySavedDataAboutUser =
        await _getIt<InfoAboutMeService>().isInfoAboutMeExist();
    print("czy zapisane"+isAlreadySavedDataAboutUser.toString());
    print("mail"+userEmail);

    if (!isAlreadySavedDataAboutUser) {
      Result userDataResult = await _getIt<GetUserDataRequest>().getUserDataWithEmail(EmailData(email: userEmail));

      print(userDataResult);

      if (userDataResult.isSuccess()) {
        UserData userData = userDataResult.getData();

        _getIt<InfoAboutMeService>().insertFirstInfoAboutMe(InfoAboutMe(id: userData.id!, name: userData.name!, surname: userData.surname!, email: userData.email!));


        _getIt<InfoAboutMeService>().setId(userData.id!);
        _getIt<InfoAboutMeService>().setName(userData.name!);
        _getIt<InfoAboutMeService>().setSurname(userData.surname!);
        _getIt<InfoAboutMeService>().setEmail(userData.email!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 100, right: 20, left: 20),
            backgroundColor: MainAppStyle.mainColorApp,
            content: Text(AppLocalizations.of(context)!.passwordHasBenReset)));

        _redirectToLoginView();
      }
    }
  }

  void _redirectToLoginView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _saveUserLoginAuth(Result resultLoginRequest) async {
    TokensData tokens = resultLoginRequest.getData() as TokensData;

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
