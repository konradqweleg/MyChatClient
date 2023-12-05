import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
import '../../style/main_style.dart';
import '../common/input/input_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm(this.registerUserRequest ,{super.key});

  RegisterUserRequest registerUserRequest;

  @override
  State<RegisterForm> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  static const double _breakBetweenNameAppAndForm = 20.0;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  bool _isOccupiedEmail = false;
  bool _isShowAccountNotActive = false;


  bool isValidateForm() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
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

  void _showButtonAccountNotActive(){
    setState(() {
      _isShowAccountNotActive = true;
    });

  }

  void _register() async{
    bool isValidateFormData = isValidateForm();
    if (!isValidateFormData) {
      return;
    }

    UserRegisterData registerData = UserRegisterData(
        _emailController.text,
        _usernameController.text,
        _surnameController.text,
        _passwordController.text);

    Future<RegisterResponse> registerRequestResult = widget.registerUserRequest.register(registerData);
    RegisterResponse registerResponse = await registerRequestResult;
    if(registerResponse == RegisterResponse.userAlreadyExists){
      setState(() {
        _isOccupiedEmail = true;
      });
      return;
    }else if(registerResponse == RegisterResponse.error){
      return;
    }else if(registerResponse == RegisterResponse.accountNotActive){
      _showButtonAccountNotActive();
      return;
    }



    _goToConfirmAccount();
  }

  String _getErrorMessageWhenOccupiedEmail() {
    String noError = "";
    return _isOccupiedEmail
        ? AppLocalizations.of(context)!.emailOccupiedError
        : noError;
  }


  Widget _showActionTextGoToConfirmAccountIfAccountNotActivated(){
  return  Visibility(
    visible: _isShowAccountNotActive,
    child: Text.rich(TextSpan(
          text: AppLocalizations.of(context)!
              .alreadyExistsEmailAccountNotActive,
          children: <InlineSpan>[
            TextSpan(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: MainAppStyle.mainColorApp),
              text: AppLocalizations.of(context)!
                  .goToActiveAccountPanel,
              recognizer: TapGestureRecognizer()
                ..onTap = null,
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
              const SizedBox(height: _breakBetweenNameAppAndForm),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  _getErrorMessageWhenOccupiedEmail(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

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
