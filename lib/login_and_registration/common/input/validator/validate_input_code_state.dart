import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum ValidatedInputCodeState{
  ok,
  emptyText,
  notEnoughDigits;

  String? mapStateToErrorMessage(BuildContext context) {
    String? noError = null;

    if (index == 1) {
      return AppLocalizations.of(context)!.pleaseEnterCode;
    }else if (index == 2){
      return AppLocalizations.of(context)!.notEnoughCharactersInCode;
    }
    return noError;
  }
}

