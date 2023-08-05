import 'dart:developer';

import 'package:flutter/material.dart';

import '../../animations/PageRouteTransition.dart';
import '../../style/main_style.dart';
import '../reset_password/reset_password.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          PageRouteTransition.transitionAfterDelay(
            context: context,
            destination: const ResetPasswordView(),
          );
        },
        child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("----------"),
          Container(
            height: 28,
            margin: const EdgeInsets.all(10.0),
            child: const ButtonWhiteWithBorder(
              text: "I FORGOT MY PASSWORD",
            ),
          ),
          const Text("----------")
        ],
      ),
      );


  }
}


class ButtonWhiteWithBorder extends StatelessWidget {
  const ButtonWhiteWithBorder({required this.text, super.key});

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








