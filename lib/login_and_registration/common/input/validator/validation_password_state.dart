import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ValidatedPasswordState {
  ok,
  emptyText;

  String mapStateToErrorMessage(BuildContext context) {
    String noError = "";

    if (index == 1) {
      return AppLocalizations.of(context)!.pleaseEnterPassword;
    }
    return noError;
  }
}
