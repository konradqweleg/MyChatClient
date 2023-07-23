import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
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
