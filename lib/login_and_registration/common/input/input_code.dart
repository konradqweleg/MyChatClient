import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputCode extends StatelessWidget {
  const InputCode(this.controller,{super.key});

  final TextEditingController controller;
  static const int codeCorrectLength = 4;

  String? _validateInputCode(BuildContext context,String? text){
    const  correctCode = null;

    if(text == null){
      return AppLocalizations.of(context)!.pleaseEnterCode;
    }

    if(text.length < codeCorrectLength){
      return AppLocalizations.of(context)!.notEnoughCharactersInCode;
    }
    return correctCode;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(codeCorrectLength),
        ],
        style: const TextStyle(fontSize: 25.0),
        keyboardType: TextInputType.number,
        controller: controller,
        validator:(code)=> _validateInputCode(context,code),
        decoration:   InputDecoration(
          suffixIcon: const Icon(Icons.numbers),
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.descriptionInputCodeForm,
        ),
      ),
    );
  }
}
