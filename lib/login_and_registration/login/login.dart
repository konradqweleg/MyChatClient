import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/common/reset_password.dart';
import 'package:my_chat_client/login_and_registration/login/other_form_login/login_with_google_or_facebook.dart';

import '../../style/main_style.dart';
import 'login_form.dart';

void main() => runApp(const ScrollLogin());

class ScrollLogin extends StatelessWidget {
  const ScrollLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: MainAppStyle.defaultMainPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Container(
                    // Another fixed-height child.
                    height: 410.0,
                    alignment: Alignment.center,
                    child: const LoginForm(),
                  ),
                  const SizedBox(height: 30),
                  const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CreateNewAccount(),
                        ResetPassword(),
                      ]),
                  const SizedBox(height: 20),
                  const LoginWithGoogleOrFacebook()

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
















// class otherActionWithAccount extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Text(
//           "CREATE NEW \n ACCOUNT",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//           textAlign: TextAlign.center,
//         ),
//
//         Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("----------"),
//               Container(
//                 margin: const EdgeInsets.all(10.0),
//                 child: ButtonWhiteWithBorder(
//                   text: "I FORGOT MY PASSWORD",
//                   borderColor: const Color(0xff3B5999),
//                 ),
//               ),
//               Text("----------")
//             ],
//           ),
//         ),
//
//         // Expanded(flex: 1,child:
//         // const Spacer(),
//         // ),
//       ],
//     );
//   }
// }
//
// class ButtonWhiteWithBorder extends StatelessWidget {
//   late String textButton;
//
//   late Color colorBackground;
//
//   ButtonWhiteWithBorder(
//       {required String text, required Color borderColor, super.key}) {
//     textButton = text;
//     colorBackground = borderColor;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: null,
//       style: ButtonStyle(
//         minimumSize: MaterialStateProperty.all(Size.zero),
//         // Set this
//         padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//         shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
//         side: MaterialStateProperty.all(
//             BorderSide(width: 1.0, color: Color(0xff1184EF))),
//         textStyle: MaterialStateProperty.all(
//             const TextStyle(fontSize: 9.0, color: const Color(0xff000000))),
//       ),
//       child: Text(textButton),
//     );
//   }
// }
//
// class loginWithGoogleOrFaceboook extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           flex: 1,
//           child: Container(
//             margin: const EdgeInsets.all(10.0),
//             child: ButtonWithImage(
//                 text: "GOOGLE",
//                 imageAsset: "assets/google_icon.png",
//                 color: const Color(0xffFF3333)),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             margin: const EdgeInsets.all(10.0),
//             child: ButtonWithImage(
//                 text: "FACEBOOK",
//                 imageAsset: "assets/facebook_icon.png",
//                 color: const Color(0xff3B5999)),
//           ),
//         )
//       ],
//     ));
//   }
// }
//
// class ButtonWithImage extends StatelessWidget {
//   late String textButton;
//   late String imageButton;
//   late Color colorBackground;
//
//   ButtonWithImage(
//       {required String text,
//       required String imageAsset,
//       required Color color,
//       super.key}) {
//     textButton = text;
//     imageButton = imageAsset;
//     colorBackground = color;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       icon: ImageIcon(
//         AssetImage(imageButton),
//         color: null,
//       ),
//       label: Text(textButton), // <-- Text
//       style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
//           backgroundColor: colorBackground,
//           foregroundColor: Color(0xffffffff),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
//     );
//   }
// }
//
// class LoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//             flex: 1,
//             child: Container(
//               child: ElevatedButton(
//                 onPressed: () {
//                   log("Rozmiar" +
//                       MediaQuery.of(context).viewInsets.bottom.toString());
//                 },
//                 style: ButtonStyle(
//                   foregroundColor: MaterialStateProperty.all(Color(0xffffffff)),
//                   backgroundColor: MaterialStateProperty.all(Color(0xff1184EF)),
//                   padding: MaterialStateProperty.all(
//                       EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.0),
//                   )),
//                 ),
//                 child: const Text(
//                   'LOGIN',
//                   style: TextStyle(fontSize: 32),
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
// }
