import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/checkExsistsEmail.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/reset_code.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password_state.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/validate_code.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../../style/main_style.dart';
import '../common/input/input_code.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm(
      this.resetCode, this.validateCode, this.checkExistsEmail,
      {super.key});

  final ResetCode resetCode;
  final ValidateCode validateCode;
  final CheckExistsEmail checkExistsEmail;

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

  bool _isEmailExistInService() {
    return widget.checkExistsEmail.isEmailExistsInService(emailController.text);
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

    if (!_isEmailExistInService()) {
      _setStateNoExistsEmailInService();
    } else {
      _setStateSentCode();
      widget.resetCode.sendCode(context, emailController.text);
    }
  }

  void _goToInsertNewPassword() {
    PageRouteNavigation.navigationTransitionSlideFromDown(
        context: context,
        destination: NewPassword(emailController.text),
        isClearBackStack: true);
  }

  void _resetPassword() {
    bool isValidFormatCode = _isValidFormatCode();

    if (!isValidFormatCode) {
      return;
    }

    bool isGoodCode = widget.validateCode
        .isValidCode(codeController.text, emailController.text);

    if (isGoodCode) {
      _goToInsertNewPassword();
    } else {
      setState(() {
        _state = ResetPasswordState.badCode;
      });
    }
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
        Text(
          _state.getNoExistsEmailText(context),
          style: const TextStyle(color: Colors.red),
        ),
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
