import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/password_validate.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputPassword extends StatefulWidget {
  InputPassword(this.controller,{super.key});

  final TextEditingController controller;
  final PasswordValidate passwordValidate = PasswordValidate();

  @override
  State<StatefulWidget> createState() {
    return _InputPasswordState();
  }
}

class _InputPasswordState extends State<InputPassword> {

  bool passwordVisible = false;

  void _changeVisibilityPassword(){
    setState(() {
          passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        controller: widget.controller,
        validator:(password)=> widget.passwordValidate.validate(password).mapStateToErrorMessage(context),
        obscureText: !passwordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(passwordVisible ? Icons.lock_open : Icons.lock),
            onPressed: _changeVisibilityPassword,
          ),
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.enterPassword,
        ),
      ),
    );
  }
}
