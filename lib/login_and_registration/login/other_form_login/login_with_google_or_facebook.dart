import 'package:flutter/material.dart';

import 'login_facebook.dart';
import 'login_google.dart';


class LoginWithGoogleOrFacebook extends StatelessWidget {
  const LoginWithGoogleOrFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: const LoginGoogle(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: const LoginFacebook(),
            ),
          )
        ],
      ),
    );
  }
}
