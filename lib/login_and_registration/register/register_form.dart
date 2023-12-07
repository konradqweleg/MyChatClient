import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
import '../common/input/input_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  RegisterResponseStatus registerResponseStatus =
      RegisterResponseStatus.notSend;


  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }


  void _ifRequestReturnCorrectDataGoToActiveAccountPage() {
    if (registerResponseStatus == RegisterResponseStatus.ok) {
      _goToConfirmAccount();
    }
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
    UserRegisterData registerData = UserRegisterData(
        _emailController.text,
        _usernameController.text,
        _surnameController.text,
        _passwordController.text);


    Future<RegisterResponseStatus> registerRequestResultFuture =
    widget._registerUserRequestAction.register(registerData);

    _clearAllError();

    RegisterResponseStatus responseStatus = await registerRequestResultFuture;

    setState(()  {

       registerResponseStatus = responseStatus;
      _ifRequestReturnCorrectDataGoToActiveAccountPage();
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
      registerResponseStatus = RegisterResponseStatus.notSend;
    });
  }

  Widget _showMessageErrorIfRequestReturnError() {
    bool isShowErrorMessage =
        (registerResponseStatus == RegisterResponseStatus.error);

    return Visibility(
      visible: isShowErrorMessage,
      child: Text.rich(TextSpan(children: <InlineSpan>[
        TextSpan(
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          text:
              "${AppLocalizations.of(context)!.errorRequestInformationOnInternetAccessCheck} ",
          recognizer: TapGestureRecognizer()..onTap = null,
        )
      ])),
    );
  }

  Widget _showOccupiedEmailMessageIfEmailIsOccupied() {
    bool isShowErrorOccupiedEmail =
        (registerResponseStatus == RegisterResponseStatus.userAlreadyExists);

    return Visibility(
      visible: isShowErrorOccupiedEmail,
      child: Container(
        alignment: Alignment.topLeft,
        child: Text(
          AppLocalizations.of(context)!.emailOccupiedError,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _showActionTextGoToConfirmAccountIfAccountNotActivated() {
    bool showErrorMessageAccountAlreadyNotActivated = (registerResponseStatus == RegisterResponseStatus.accountNotActive);

    return Visibility(
      visible: showErrorMessageAccountAlreadyNotActivated,
      child: Text.rich(TextSpan(children: <InlineSpan>[
        TextSpan(
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          text:
              "${AppLocalizations.of(context)!.alreadyExistsEmailAccountNotActive} ",
          recognizer: TapGestureRecognizer()..onTap = null,
        ),
        TextSpan(
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: MainAppStyle.mainColorApp),
          text: AppLocalizations.of(context)!.goToActiveAccountPanel,
          recognizer: TapGestureRecognizer()..onTap = null,
        )
      ])),
    );
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
              _showOccupiedEmailMessageIfEmailIsOccupied(),
              _showMessageErrorIfRequestReturnError(),
              _showActionTextGoToConfirmAccountIfAccountNotActivated(),
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
