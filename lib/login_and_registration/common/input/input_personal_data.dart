import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputData extends StatelessWidget {
  InputData(this.controller,this.text,this.iconData ,{super.key});

  TextEditingController controller;
  String text;
  IconData iconData;

  int minTextLength = 2;
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
        controller: controller,
        validator: (emailAddress) {
          return getErrorWhenTextIsTooShort(emailAddress);
        },
        decoration:  InputDecoration(
          suffixIcon: Icon(iconData),
          border: const UnderlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}
