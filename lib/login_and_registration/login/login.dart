import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/other_form_login/login_with_google_or_facebook.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_http.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import '../../database/db_services/info_about_me/info_about_me_service.dart';
import '../../main_conversations_list/main_conversation_list.dart';
import '../../style/main_style.dart';
import 'login_form.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // final GetIt _getIt = GetIt.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   _redirectToMainConversationWhenValidRefreshToken();
  // }
  //
  // Future<void> _redirectToMainConversationWhenValidRefreshToken() async {
  //
  //   bool isAlreadySavedDataAboutUser =
  //       await _getIt<InfoAboutMeService>().isInfoAboutMeExist();
  //
  //   if(isAlreadySavedDataAboutUser){
  //     _getIt<RequestIsCorrectTokens>().isCorrectSavedTokens().then((isValidTokens) {
  //       if (isValidTokens) {
  //         _redirectToMainConversationView();
  //       }
  //     });
  //   }
  //
  //
  // }
  //
  // void _redirectToMainConversationView() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const MainConversationList()),
  //   );
  // }

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
                padding: MainAppStyle.defaultMainPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Container(
                      // Another fixed-height child.
                      height: 400.0,
                      alignment: Alignment.center,
                      child: LoginForm(loginRequest: LoginRequestHttp()),
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
