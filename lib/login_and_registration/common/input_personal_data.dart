import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputData extends StatelessWidget {
  InputData(this.controller,this.text ,{super.key});

  TextEditingController controller;
  String text;

  // String? getErrorMessageInvalidMailFormat(String? email) {
  //   const validFormat = null;
  //
  //   if (email == null || email.isEmpty) {
  //     return 'Please enter an email';
  //   } else if (!EmailValidator.validate(email)) {
  //     return 'The email address is in an invalid format';
  //   }
  //
  //   return validFormat;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        controller: controller,
        // validator: (emailAddress) {
        //   return getErrorMessageInvalidMailFormat(emailAddress);
        // },
        decoration:  InputDecoration(
          suffixIcon: Icon(Icons.message),
          border: UnderlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}
