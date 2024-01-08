import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_request_status.dart';
import 'package:my_chat_client/login_and_registration/common/error_message.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_status.dart';
import 'package:my_chat_client/style/main_style.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../common/result.dart';
import '../common/errors.dart';
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


class ConfirmCodeRegisterForm extends StatefulWidget {
  const ConfirmCodeRegisterForm(this.userRegisterData, this.checkConfirmCodeRequest,this.resendConfirmAccountCodeRequest,
      {super.key});

  final UserRegisterData userRegisterData;
  final ConfirmAccountRequest checkConfirmCodeRequest;
  final ResendConfirmAccountCodeRequest resendConfirmAccountCodeRequest;

  @override
  State<ConfirmCodeRegisterForm> createState() {
    return _ConfirmCodeRegisterFormState();
  }
}

class _ConfirmCodeRegisterFormState extends State<ConfirmCodeRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;
  TextEditingController controller = TextEditingController();
  Result _confirmAccountRequestStatus = Result.empty();
  final Errors _matchedErrorToErrorMessage = Errors();


  void _initMatchedErrorToErrorMessage() {
    if(_matchedErrorToErrorMessage.isInit()) {
      _matchedErrorToErrorMessage.registerMatchErrorToResultStatus(
          ErrorMessage.error(AppLocalizations.of(context)!
              .errorRequestInformationOnInternetAccessCheck,
              Result.error(ConfirmAccountRequestStatus.error) ));
      _matchedErrorToErrorMessage.registerMatchErrorToResultStatus(
          ErrorMessage.error(
              AppLocalizations.of(context)!.badCreateAccountConfirmCode,
              Result.error(ConfirmAccountRequestStatus.badCode)));
      _matchedErrorToErrorMessage.registerMatchErrorToResultStatus(
          ErrorMessage.error(
              AppLocalizations.of(context)!.notSendActiveAccountCodeForThisUser,
              Result.error(ConfirmAccountRequestStatus.noCodeForUser)));

    }


  }


  void _resendConfirmCode() {

    EmailData userEmail = EmailData(email: widget.userRegisterData.email);
    Future<Result> requestResendConfirmAccountCodeStatus =  widget.resendConfirmAccountCodeRequest.resendActiveAccountCode(userEmail);

    requestResendConfirmAccountCodeStatus.then((value)  {
      Result resultConfirmAccountCodeStatus = value;
      if(resultConfirmAccountCodeStatus.isSuccess()){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MainAppStyle.mainColorApp,
            content: Text(AppLocalizations.of(context)!.sendConfirmCode)));
      }else if (resultConfirmAccountCodeStatus.isError()){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: MainAppStyle.mainColorApp,
            content: Text(AppLocalizations.of(context)!.errorRequestInformationOnInternetAccessCheck)));
      }

    });


  }

  String _showWarningWhenIsErrorInRequest() {
    const String validCode = "";

    if (_confirmAccountRequestStatus.isError()) {
      return _matchedErrorToErrorMessage.getErrorMessage();
    } else {
      return validCode;
    }
  }

  bool _isValidFormatCode() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }


  void _makeRequestCheckActiveAccountCode() {
    // _initMatchedErrorToErrorMessage();

    ConfirmAccountData confirmAccountData = ConfirmAccountData(email: widget.userRegisterData.email, code: controller.text);
    Future<Result> requestActiveAccountResult = widget.checkConfirmCodeRequest.confirmAccount(confirmAccountData);

    requestActiveAccountResult.then((value) {

      setState(() {
        _confirmAccountRequestStatus = value;
        if (_confirmAccountRequestStatus.isError()) {
          _initMatchedErrorToErrorMessage();
          _matchedErrorToErrorMessage.setActualError(
              _confirmAccountRequestStatus);
        }
        if (_confirmAccountRequestStatus.isSuccess()) {
          _logIn();
        }
      });
    });
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

    _makeRequestCheckActiveAccountCode();
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
                  style: DefaultTextStyle
                      .of(context)
                      .style,
                  children: <TextSpan>[
                    TextSpan(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MainAppStyle.mainColorApp),
                        text: " ${AppLocalizations.of(context)!.resendCode}",
                        recognizer: TapGestureRecognizer()
                          ..onTap = _resendConfirmCode),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              InputCode(controller),
              Text(
                _showWarningWhenIsErrorInRequest(),
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
