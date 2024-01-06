import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum ValidatedInputState{
  ok,
  emptyText,
  tooShort;

  String? mapStateToErrorMessage(BuildContext context) {
    String? noError = null;

    if (index == 1) {
      return AppLocalizations.of(context)!.notEnoughLettersEntered;
    }else if (index == 2){
      return AppLocalizations.of(context)!.tooShortText;
    }
    return noError;
  }
}