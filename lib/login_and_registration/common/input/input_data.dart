import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputData extends StatelessWidget {
  const InputData(this.controller,this.text,this.iconInputForm ,{super.key});

  final TextEditingController controller;
  final String text;
  final IconData iconInputForm;


  String? validateForm(BuildContext context,String? text){

    const int minTextLength = 2;
    if(text == null){
      return AppLocalizations.of(context)!.notEnoughLettersEntered;
    }

    if(text.length <= minTextLength){
      return AppLocalizations.of(context)!.notEnoughLettersEntered;
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        controller: controller,
        validator: (data)=> validateForm(context,data),
        decoration:  InputDecoration(
          suffixIcon: Icon(iconInputForm),
          border: const UnderlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}
