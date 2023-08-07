import 'package:flutter/material.dart';
import '../../../navigation/page_route_navigation.dart';
import '../../../style/main_style.dart';
import '../../reset_password/reset_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordButton extends StatefulWidget {
  const ResetPasswordButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordButtonState();
  }
}

class _ResetPasswordButtonState extends State<ResetPasswordButton> {


  void navigateToResetPasswordForm(){
    PageRouteNavigation.navigation(
      context: context,
      destination: const ResetPassword(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: navigateToResetPasswordForm,
        child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("----------"),
          Container(
            height: 28,
            margin: const EdgeInsets.all(10.0),
            child:  _ButtonWhiteWithBorder(
              text:  AppLocalizations.of(context)!.forgotPassword,
            ),
          ),
          const Text("----------")
        ],
      ),
      );

  }
}


class _ButtonWhiteWithBorder extends StatelessWidget {
  const _ButtonWhiteWithBorder({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        // Set this
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        side: MaterialStateProperty.all(
          const BorderSide(width: 1.0, color: MainAppStyle.mainColorApp),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 9.0, color: Colors.black),
        ),
      ),
      child: Text(text),
    );
  }
}








