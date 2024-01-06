import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../../style/main_style.dart';
import '../common/errors.dart';

import '../common/input/input_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common/error_message.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm(this._registerUserRequestAction, {super.key});

  final RegisterUserRequest _registerUserRequestAction;

  @override
  State<RegisterForm> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();


  final Errors _matchedErrorInRequestToErrorMessage = Errors();
  Result _registerRequestResult = Result.empty();


  void _initUserMessageForErrors() {
    if(_matchedErrorInRequestToErrorMessage.isInit()) {
      _matchedErrorInRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(AppLocalizations.of(context)!.errorRequestInformationOnInternetAccessCheck, Result.error(RegisterResponseStatus.error)));
      _matchedErrorInRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(AppLocalizations.of(context)!.emailOccupiedError, Result.error(RegisterResponseStatus.userAlreadyExists)));
      _matchedErrorInRequestToErrorMessage.registerMatchErrorToResultStatus(ErrorMessage.error(AppLocalizations.of(context)!.alreadyExistsEmailAccountNotActive, Result.error(RegisterResponseStatus.accountNotActive)));
    }
  }



  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }


  void _goToConfirmAccount() {
    UserRegisterData registerData = UserRegisterData(
        _emailController.text,
        _usernameController.text,
        _surnameController.text,
        _passwordController.text);

    PageRouteNavigation.navigation(
        context: context,
        destination: ConfirmRegisterCode(registerData),
        isClearBackStack: true);
  }



  void _makeRequestRegister() async {
    _clearAllError();
    UserRegisterData registerData = UserRegisterData(
        _emailController.text,
        _usernameController.text,
        _surnameController.text,
        _passwordController.text);


    Future<Result> registerRequestResultFuture = widget._registerUserRequestAction.register(registerData);


    registerRequestResultFuture.then((Result value){
      _initUserMessageForErrors();
      setState(() {
        _registerRequestResult = value;
        _matchedErrorInRequestToErrorMessage.setActualError(_registerRequestResult);
      });

      if(_registerRequestResult.isSuccess()){
            _goToConfirmAccount();
      }

    });


  }

  void _register() async {
    _hideKeyboard();
    _clearAllError();

    bool isCorrectValidationFormDataBeforeRequest = _isValidateFormData();
    if (isCorrectValidationFormDataBeforeRequest) {
      _makeRequestRegister();
    }

  }


  bool _isValidateFormData() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  void _clearAllError() {
   setState(() {
     _registerRequestResult = Result.empty();
   });
  }

  Widget _showErrorWhenErrorInRequest() {

    if(!_registerRequestResult.isError()) {
      return const SizedBox.shrink();
    }

    if(_registerRequestResult.isError() && _registerRequestResult.getData() == RegisterResponseStatus.accountNotActive) {
      return Text.rich(TextSpan(children: <InlineSpan>[
        TextSpan(
          style:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          text:
          _matchedErrorInRequestToErrorMessage.getErrorMessage(),
          recognizer: TapGestureRecognizer()..onTap = _goToConfirmAccount,
        ),
        TextSpan(
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: MainAppStyle.mainColorApp),
          text:  " ${AppLocalizations.of(context)!.goToActiveAccountPanel}",
          recognizer: TapGestureRecognizer()..onTap = _goToConfirmAccount,
        )
      ])
      );
    }
    else
    {
      return Text(
        _matchedErrorInRequestToErrorMessage.getErrorMessage(),
        style: const TextStyle(color: Colors.red),
      );
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
              const SizedBox(height: MainAppStyle.breakBetweenNameAppAndForm),
              _showErrorWhenErrorInRequest(),
              InputEmail(_emailController),
              InputData(
                _usernameController,
                AppLocalizations.of(context)!.username,
                Icons.person,
              ),
              InputData(
                _surnameController,
                AppLocalizations.of(context)!.surname,
                Icons.person,
              ),
              InputPassword(_passwordController),
              const SizedBox(
                height: 10,
              ),
              MainActionButton(
                text: AppLocalizations.of(context)!.registerButtonText,
                action: _register,
              ),
            ],
          )),
    );
  }
}
