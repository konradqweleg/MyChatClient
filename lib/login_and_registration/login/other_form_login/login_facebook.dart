import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/button/button_with_image.dart';

import '../../style/style_login_and_registration.dart';



class LoginFacebook extends StatelessWidget {
  const LoginFacebook({super.key});

  void _loginViaFacebook(){

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: Container(
        padding:const EdgeInsets.only(left:10.0,right:10) ,
        height: 50,
        child:  ButtonWithImage(
          text: "FACEBOOK",
          action: _loginViaFacebook,
          image: "assets/facebook_icon.png",
          backgroundColor: const Color(StyleLoginAndRegistration.facebookColor),
        ),
      ),
    );
  }
}
