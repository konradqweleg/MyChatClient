import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/check_exists_email_request.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/email_and_code_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/is_correct_reset_password_code.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/send_reset_password_code_request.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/reset_code.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password_state.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/validate_code.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../../style/main_style.dart';
import '../common/error_message.dart';
import '../common/errors.dart';
import '../common/input/input_code.dart';
import '../common/result.dart';
import '../confirm_code/request/resend_active_account_code/email_data.dart';
import 'check/requests/check_exists_email_status.dart';
import 'check/requests/request_send_reset_password_code_status.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm(
      this.resetCode, this.isCorrectResetPasswordCode, this.sendResetPasswordCodeRequest,
      {super.key});

  final ResetCode resetCode;
  final IsCorrectResetPasswordCode isCorrectResetPasswordCode;
  final SendResetPasswordCodeRequest sendResetPasswordCodeRequest;

  @override
  State<ResetPasswordForm> createState() {
    return _ResetPasswordFormState();
  }
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKeyMail = GlobalKey<FormState>();
  final _formKeyCode = GlobalKey<FormState>();
  static const double breakBetweenNameAppAndForm = 20.0;

  ResetPasswordState _state = ResetPasswordState.start;
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final Errors _matchedErrorToErrorMessageCheckIfEmailExistsInServices = Errors();

  bool _isValidFormatEmail() {
    if (!_formKeyMail.currentState!.validate()) {
      return false;
    }
    return true;
  }

  bool _isValidFormatCode() {
    if (!_formKeyCode.currentState!.validate()) {
      return false;
    }
    return true;
  }



  void _initMatchedErrorToErrorMessage() {
    if(_matchedErrorToErrorMessageCheckIfEmailExistsInServices.isInit()) {
      _matchedErrorToErrorMessageCheckIfEmailExistsInServices.registerMatchErrorToResultStatus(
          ErrorMessage.error(AppLocalizations.of(context)!
              .errorRequestInformationOnInternetAccessCheck,
              Result.error(RequestSendResetPasswordCodeStatus.error) ));
      _matchedErrorToErrorMessageCheckIfEmailExistsInServices.registerMatchErrorToResultStatus(
          ErrorMessage.error(
              AppLocalizations.of(context)!.userWithSpecifiedEmailNotExist,
              Result.error(RequestSendResetPasswordCodeStatus.userNotExist)));
      _matchedErrorToErrorMessageCheckIfEmailExistsInServices.registerMatchErrorToResultStatus(
          ErrorMessage.error(
              AppLocalizations.of(context)!.accountNotActive,
              Result.error(RequestSendResetPasswordCodeStatus.accountNotActive)));

    }


  }

  void _sendCode() {

    setState(() {
      _matchedErrorToErrorMessageCheckIfEmailExistsInServices.clearError();
    });


    EmailData userEmail = EmailData(email: emailController.text);
    Future<Result> requestSendResetPasswordCodeResult =  widget.sendResetPasswordCodeRequest.sendResetPasswordCode(userEmail);

    requestSendResetPasswordCodeResult.then((value)  {
      Result resultSendResetPasswordCodeRequest = value;
      print(resultSendResetPasswordCodeRequest);
      if(resultSendResetPasswordCodeRequest.isSuccess()){
        _setStateSentCode();
        widget.resetCode.sendCode(context, emailController.text);
      }else if (resultSendResetPasswordCodeRequest.isError()){

        _initMatchedErrorToErrorMessage();
        setState(() {
          _matchedErrorToErrorMessageCheckIfEmailExistsInServices.setActualError(resultSendResetPasswordCodeRequest);
        });


        if(resultSendResetPasswordCodeRequest.getData() == RequestCheckExistsEmailStatus.userNotExist) {
          _setStateNoExistsEmailInService();
        }



      }

    });


  }

  Widget _showErrorWhenIsErrorInRequestSendResetPasswordCode() {
    print(_matchedErrorToErrorMessageCheckIfEmailExistsInServices.isError());
    if(_matchedErrorToErrorMessageCheckIfEmailExistsInServices.isError()){
      String errorMessage = _matchedErrorToErrorMessageCheckIfEmailExistsInServices.getErrorMessage();
         return  Text(
          errorMessage,
          style: const TextStyle(color: Colors.red),
      );
    }

    return const SizedBox(height: 0,);
  }

  void _setStateNoExistsEmailInService() {
    setState(() {
      _state = ResetPasswordState.noExistsEmail;
    });
  }

  void _setStateSentCode() {
    setState(() {
      _state = ResetPasswordState.sendCode;
    });
  }

  void _sendResetPasswordCode() {
    bool isValidFormatMail = _isValidFormatEmail();

    if (!isValidFormatMail) {
      return;
    }

    _sendCode();

  }

  void _goToInsertNewPassword() {
    PageRouteNavigation.navigationTransitionSlideFromDown(
        context: context,
        destination: NewPassword(emailController.text),
        isClearBackStack: true);
  }

  void _validateResetPasswordCode() {
    setState(() {
      _matchedErrorToErrorMessageCheckIfEmailExistsInServices.clearError();
    });

    EmailAndCodeData emailAndCodeData = EmailAndCodeData( email: emailController.text, code: codeController.text);
    Future<Result> requestIsCorrectResetPasswordCode =  widget.isCorrectResetPasswordCode.isCorrectResetPasswordCode(emailAndCodeData);

    requestIsCorrectResetPasswordCode.then((value)  {
      Result resultSendResetPasswordCodeRequest = value;
      print(resultSendResetPasswordCodeRequest);
      if(resultSendResetPasswordCodeRequest.isSuccess()){
        _goToInsertNewPassword();
      }else if (resultSendResetPasswordCodeRequest.isError()){

        _initMatchedErrorToErrorMessage();
        setState(() {
          _matchedErrorToErrorMessageCheckIfEmailExistsInServices.setActualError(resultSendResetPasswordCodeRequest);
        });


        setState(() {
          _state = ResetPasswordState.badCode;
        });



      }

    });
  }

  void _resetPassword() {
    bool isValidFormatCode = _isValidFormatCode();

    if (!isValidFormatCode) {
      return;
    }

    _validateResetPasswordCode();
    // bool isGoodCode = widget.validateCode
    //     .isValidCode(codeController.text, emailController.text);
    //
    // if (isGoodCode) {
    //   _goToInsertNewPassword();
    // } else {
    //   setState(() {
    //     _state = ResetPasswordState.badCode;
    //   });
    // }
  }

  void _sendResetPasswordCodeOnEmail() {
    widget.resetCode.sendCode(context, emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: const NameApp(),
        ),
        const SizedBox(height: breakBetweenNameAppAndForm),
        Text.rich(TextSpan(
            text: AppLocalizations.of(context)!
                .descriptionSendMailWithResetPasswordCode,
            children: <InlineSpan>[
              TextSpan(
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MainAppStyle.mainColorApp),
                text: _state.getResendCodeText(context),
                recognizer: TapGestureRecognizer()
                  ..onTap = _sendResetPasswordCodeOnEmail,
              )
            ])),
        Form(key: _formKeyMail, child: InputEmail(emailController,isEnabled: _state.isSendCodeButtonEnabled,)),
        _showErrorWhenIsErrorInRequestSendResetPasswordCode(),
        // Text(
        //   _state.getNoExistsEmailText(context),
        //   style: const TextStyle(color: Colors.red),
        // ),
        MainActionButton(
          text: AppLocalizations.of(context)!.sendResetPasswordCode,
          action:
              _state.isSendCodeButtonEnabled ? _sendResetPasswordCode : null,
          backgroundColor: _state.colorSendCodeButton,
        ),
        const SizedBox(height: 15),
        Text(
          AppLocalizations.of(context)!.enterCodeReceivedOnEmail,
          textAlign: TextAlign.center,
        ),
        Form(
            key: _formKeyCode,
            child: InputCode(
              codeController,
              isEnabled: _state.isEnableEnterCode,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(
          _state.getMessageBadCode(context),
          style: const TextStyle(color: Colors.red),
        ),
        MainActionButton(
            text: AppLocalizations.of(context)!.resetPassword,
            action: _state.isResetPasswordButtonEnabled ? _resetPassword : null,
            backgroundColor: _state.colorResetPasswordButton),

      ],
    ));
  }
}
