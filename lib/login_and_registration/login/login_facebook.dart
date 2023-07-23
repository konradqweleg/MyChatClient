import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/button_with_image.dart';

import '../style/style_login_and_registration.dart';

class LoginFacebook extends StatelessWidget {
  const LoginFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: Container(
        padding:const EdgeInsets.only(left:10.0,right:10) ,
        height: 50,
        child: const ButtonWithImage(
          text: "FACEBOOK",
          image: "assets/facebook_icon.png",
          backgroundColor: Color(StyleLoginAndRegistration.facebookColor),
        ),
      ),
    );
  }
}
