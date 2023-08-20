import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ValidatedEmailState {
  ok,
  emptyText,
  badFormat;

  String? mapStateToErrorMessage(BuildContext context) {
    String? noError = null;

     if (index == 1) {
      return AppLocalizations.of(context)!.enterEmail;
    } else if(index == 2) {
      return AppLocalizations.of(context)!.invalidEmailFormat;
    }else{
       return noError;
     }
  }
}
