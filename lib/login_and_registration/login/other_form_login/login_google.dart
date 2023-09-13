import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/button/button_with_image.dart';

import '../../style/style_login_and_registration.dart';



class LoginGoogle extends StatelessWidget {
  const LoginGoogle({super.key});


  void _loginViaGoogle(){

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StyleLoginAndRegistration.defaultInputHeight,
      child: Container(
        height: 50,
        padding:const EdgeInsets.only(left:10.0,right:10) ,
        child:  ButtonWithImage(
          text: "GOOGLE",
          action: _loginViaGoogle ,
          image: "assets/google_icon.png",
          backgroundColor: Color(StyleLoginAndRegistration.googleColor),
        ),
      ),
    );
  }
}
