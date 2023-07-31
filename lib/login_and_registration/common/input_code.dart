//

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputCode extends StatelessWidget {
  InputCode(this.controller,{super.key});

  TextEditingController controller;


  int minTextLength = 4;
  String getErrorWhenTextIsTooShort(String? text){

    if(text == null){
      return "Not enough letters entered";
    }

    if(text!.length <= minTextLength){
      return "Not enough letters entered";
    }
    return "";
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (emailAddress) {
          return getErrorWhenTextIsTooShort(emailAddress);
        },
        decoration:  InputDecoration(
          suffixIcon: Icon(Icons.numbers),
          border: const UnderlineInputBorder(),
          labelText: 'Code',
        ),
      ),
    );
  }
}
