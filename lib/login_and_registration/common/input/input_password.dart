import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputPassword extends StatefulWidget {
  InputPassword(this.passwordController,{super.key});

  TextEditingController passwordController;

  @override
  State<StatefulWidget> createState() {
    return InputPasswordState();
  }
}

class InputPasswordState extends State<InputPassword> {

  bool passwordVisible = false;


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
        controller: widget.passwordController,
        validator: (password) {
          return getErrorMessageInvalidPasswordFormat(password);
        },
        obscureText: !passwordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(passwordVisible ? Icons.lock_open : Icons.lock),
            onPressed: () {
              setState(
                () {
                  passwordVisible = !passwordVisible;
                },
              );
            },
          ),
          border: const UnderlineInputBorder(),
          labelText: 'Enter your password',
        ),
      ),
    );
  }
}
