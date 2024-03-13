import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
import '../../database/db_services/info_about_me/info_about_me_service.dart';
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


class LoginForm extends StatefulWidget {
  const LoginForm({required this.loginRequest, super.key});

  final LoginRequest loginRequest;

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

enum SaveDataAboutUserStatus {
  success,
  dataAlreadySaved,
  error,
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


  void _logIn() {

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

    LoginData loginData = LoginData(email: emailController.text, password: passwordController.text);

    Result requestLoginResult = await  widget.loginRequest.login(loginData);
    if (requestLoginResult.isSuccess()) {
      _saveUserLoginAuth(requestLoginResult);
      await _savedDataAboutUser(emailController.text);
      bool isCorrectlySavedDataAboutUser = await _isSavedDataAboutUser(emailController.text);
      if (isCorrectlySavedDataAboutUser) {
        _logIn();
      }
    } else if (requestLoginResult.isError()) {
      _initMatchedErrorToErrorMessage();
      setState(() {
        _matchedErrorToErrorMessageLoginRequest
            .setActualError(requestLoginResult);
      });
    }


  }

  Future<bool> _isSavedDataAboutUser(String userEmail) async {
    return await _getIt<InfoAboutMeService>().isInfoAboutMeExist();
  }



  Future<void> _savedDataAboutUser(String userEmail) async {
    Result<SaveDataAboutUserStatus> saveDataAboutUserStatus = await _savedDataAboutUser2(userEmail);

    if (saveDataAboutUserStatus.isError()) {
      _showErrorDownloadInfoDataAboutUserFromServer();
    }
  }

    Future<Result<SaveDataAboutUserStatus>> _savedDataAboutUser2(String userEmail)   async {
    bool isAlreadySavedDataAboutUser = await _getIt<InfoAboutMeService>().isInfoAboutMeExist();
    if (!isAlreadySavedDataAboutUser) {
      return await _downloadDataAboutUserFromServerBasedOnEmail(userEmail);
    }else{
      return Result.success(SaveDataAboutUserStatus.success);
    }

  }

  Future<void> _savedUserDataInDb(UserData userData) async {
    return _getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(id: userData.id!, name: userData.name!, surname: userData.surname!, email: userData.email!));
  }

    Future<Result<SaveDataAboutUserStatus>> _downloadDataAboutUserFromServerBasedOnEmail(String userEmail) async {
    Result userDataResult = await _getIt<GetUserDataRequest>().getUserDataWithEmail(EmailData(email: userEmail));
    if (userDataResult.isSuccess()) {
      UserData userData = userDataResult.getData();
      await  _savedUserDataInDb(userData);
      return Result.success(SaveDataAboutUserStatus.success);
    } else {
      return Result.error(SaveDataAboutUserStatus.error);
    }
  }

  void _showErrorDownloadInfoDataAboutUserFromServer() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100, right: 20, left: 20),
        backgroundColor: MainAppStyle.mainColorApp,
        content: Text(AppLocalizations.of(context)!
            .errorDownloadInfoDataAboutUserFromServer)));
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
