import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/input/validator/email_validate.dart';
import 'package:my_chat_client/login_and_registration/style/style_login_and_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputEmail extends StatelessWidget {
  InputEmail(this.controller, {this.isEnabled = true,super.key});

  TextEditingController controller;
  EmailValidate emailValidator = EmailValidate();
  bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: TextFormField(
        enabled: isEnabled,
        controller: controller,
        validator: (mail) =>
            emailValidator.validate(mail).mapStateToErrorMessage(context),
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.message),
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.descriptionInputEnterEmail,
        ),
      ),
    );
  }
}
