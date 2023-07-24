import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});


  String? getErrorMessageInvalidPasswordFormat(String? password) {
    const validFormat = null;

    if (password == null || password.isEmpty) {
      return 'Please enter password';
    }

    return validFormat;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        validator: (password) {
          return getErrorMessageInvalidPasswordFormat(password);
        },
        obscureText: true,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.lock),
          border: UnderlineInputBorder(),
          labelText: 'Enter your password',
        ),
      ),
    );
  }
}
