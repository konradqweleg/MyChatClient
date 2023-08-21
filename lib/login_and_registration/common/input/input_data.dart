import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/input_data_validator.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';

class InputData extends StatelessWidget {
  InputData(this.controller,this.text,this.iconInputForm ,{super.key});

  final TextEditingController controller;
  final String text;
  final IconData iconInputForm;
  final InputDataValidate dataValidate = InputDataValidate();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        controller: controller,
        validator: (data)=> dataValidate.validate(data).mapStateToErrorMessage(context),
        decoration:  InputDecoration(
          suffixIcon: Icon(iconInputForm),
          border: const UnderlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}
