import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ValidatedPasswordState {
  ok,
  emptyText,
  tooShort;

  String? mapStateToErrorMessage(BuildContext context) {
    String? noError = null;

    if (index == 1) {
      return AppLocalizations.of(context)!.pleaseEnterPassword;
    }else if (index == 2){
      return AppLocalizations.of(context)!.passwordTooShort;
    }
    return noError;
  }
}
