import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ValidatedEmailState {
  ok,
  emptyText,
  badFormat;

  String mapStateToErrorMessage(BuildContext context) {
    String noError = "";

    if (index == 0) {
      return noError;
    } else if (index == 1) {
      return AppLocalizations.of(context)!.enterEmail;
    } else {
      return AppLocalizations.of(context)!.invalidEmailFormat;
    }
  }
}
