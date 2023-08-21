import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum ValidatedInputState{
  ok,
  emptyText;

  String? mapStateToErrorMessage(BuildContext context) {
    String? noError = null;

    if (index == 1) {
      return AppLocalizations.of(context)!.notEnoughLettersEntered;
    }
    return noError;
  }
}