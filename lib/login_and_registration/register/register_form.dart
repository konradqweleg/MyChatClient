import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../../navigation/page_route_navigation.dart';
import '../../common/name_app.dart';
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

    Future<bool> registerRequestResult = widget.registerUserRequest.register(registerData);

    if(! await registerRequestResult){
      return;
    }

    _goToConfirmAccount();
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
