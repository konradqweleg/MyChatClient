import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/input_code_validate.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputCode extends StatelessWidget {
  InputCode(this.controller,{this.isEnabled = true ,super.key});

  final TextEditingController controller;
  static const int codeCorrectLength = 4;
  bool isEnabled;

  final InputCodeValidate validator = InputCodeValidate();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 150),
        enabled: isEnabled,
        inputFormatters: [
          LengthLimitingTextInputFormatter(codeCorrectLength),
        ],
        style: const TextStyle(fontSize: 25.0),
        keyboardType: TextInputType.number,
        controller: controller,
        validator:(code)=> validator.validate(code).mapStateToErrorMessage(context),
        decoration:   InputDecoration(
          suffixIcon: const Icon(Icons.numbers),
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.descriptionInputCodeForm,
        ),
      ),
    );
  }
}
