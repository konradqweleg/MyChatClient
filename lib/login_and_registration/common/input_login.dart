import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputLogin extends StatelessWidget {
  const InputLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.message),
          border: UnderlineInputBorder(),
          labelText: 'Enter your email',
        ),
      ),
    );
  }
}
