import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputEmail extends StatelessWidget {
  InputEmail(this.controller, {super.key});

  TextEditingController controller;

  String? _validateEmailFormat(BuildContext context,String? email) {
    const validFormat = null;

    if (email == null || email.isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    } else if (!EmailValidator.validate(email)) {
      return AppLocalizations.of(context)!.invalidEmailFormat;
    }

    return validFormat;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        controller: controller,
        validator:(mail)=>_validateEmailFormat(context,mail),
        decoration:  InputDecoration(
          suffixIcon: const Icon(Icons.message),
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.descriptionInputEnterEmail,
        ),
      ),
    );
  }
}
