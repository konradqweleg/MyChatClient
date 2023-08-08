import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputPassword extends StatefulWidget {
  const InputPassword(this.controller,{super.key});

  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() {
    return _InputPasswordState();
  }
}

class _InputPasswordState extends State<InputPassword> {

  bool passwordVisible = false;

  String? _validatePasswordFormat(String? password) {
    const validFormat = null;

    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterPassword;
    }

    return validFormat;
  }

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
        validator: _validatePasswordFormat,
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
