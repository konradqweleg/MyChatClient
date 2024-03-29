import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/change_password_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password_status.dart';
import '../../../common/name_app.dart';
import '../../../navigation/page_route_navigation.dart';
import '../../../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/error_message.dart';
import '../../common/errors.dart';
import '../../common/result.dart';
import '../../login/login.dart';

class NewPasswordForm extends StatefulWidget {
  NewPasswordForm(this.email,this.resetPasswordCode, this.changePassword,{super.key});

  String email;
  RequestChangePassword changePassword;
  String resetPasswordCode;

  @override
  State<NewPasswordForm> createState() {
    return _NewPasswordFormState();
  }
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  static double breakBetweenNameAppAndForm = 20.0;

  final TextEditingController passwordController = TextEditingController();
  final Errors _matchedErrorInResponseRequestToErrorMessage = Errors();

  void _initMatchedErrorToErrorMessage() {
    if (_matchedErrorInResponseRequestToErrorMessage.isInit()) {

      _matchedErrorInResponseRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(
            AppLocalizations.of(context)!.errorRequestInformationOnInternetAccessCheck,
            Result.error(RequestChangePasswordStatus.error)
         )
      );

      _matchedErrorInResponseRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(
            AppLocalizations.of(context)!.badChangePasswordCode,
            Result.error(RequestChangePasswordStatus.badChangePasswordCode)
         )
      );

      _matchedErrorInResponseRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(
            AppLocalizations.of(context)!.userOrResetPasswordCodeNotFound,
            Result.error(RequestChangePasswordStatus.resetPasswordCodeNotFoundForThisUser)
         )
      );

    }
  }


  void _backToLogin(BuildContext context){
    PageRouteNavigation.navigation(context: context,destination:  Login());
  }

  bool _isValidNewPassword() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void _showMessagePasswordHasBeenChange(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
            bottom: 100,
            right: 20,
            left: 20),
        backgroundColor: MainAppStyle.mainColorApp,
        content: Text(AppLocalizations.of(context)!.passwordHasBenReset)));
  }

  void _showMessageErrorDuringChangingPassword(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
            bottom: 100,
            right: 20,
            left: 20),
        backgroundColor: MainAppStyle.mainColorApp,
        content: Text(_matchedErrorInResponseRequestToErrorMessage.getErrorMessage())));
  }

  void _changePassword(){
    bool isValidNewPassword = _isValidNewPassword();

    if(isValidNewPassword){

      ChangePasswordData changePasswordData = ChangePasswordData(
          email: widget.email,
          code: widget.resetPasswordCode,
          password: passwordController.text,

      );
      Future<Result> requestChangePasswordStatus =  widget.changePassword.requestChangePassword(changePasswordData);

      requestChangePasswordStatus.then((value)  {
        Result resultChangePassword = value;
        if(resultChangePassword.isSuccess()){
          _showMessagePasswordHasBeenChange();
          _backToLogin(context);
        }else if (resultChangePassword.isError()){
          _initMatchedErrorToErrorMessage();
          _matchedErrorInResponseRequestToErrorMessage.setActualError(resultChangePassword);
          _showMessageErrorDuringChangingPassword();
          _backToLogin(context);
        }

      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: const NameApp(),
        ),
        SizedBox(height: breakBetweenNameAppAndForm),
        Container(
          alignment: Alignment.topLeft,
          child:  Text(
            AppLocalizations.of(context)!.enterNewPassword,
            textAlign: TextAlign.left,
          ),
        ),
        Form(key: _formKey, child: InputPassword(passwordController)),
        MainActionButton(
            text: AppLocalizations.of(context)!.resetPassword,
            action: _changePassword
        )],
    ));
  }
}
