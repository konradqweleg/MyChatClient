import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_chat_client/resources/image_resources.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/resources/text_resources.dart';

void main() {
  runApp(const LoginPanel());
}

class LoginPanel extends StatefulWidget {
  const LoginPanel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<LoginPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const MainPanel());
  }
}

//Placeholder fajnie pokazuje wielksoci
class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    const KEYBOARD_HEIGHT = 100.0;
    var isKeyboardShow =
        (MediaQuery.of(context).viewInsets.bottom > KEYBOARD_HEIGHT);

    // isKeyboardShow = false;
    log("Czy klawiatura:" + isKeyboardShow.toString());

    if (isKeyboardShow) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Spacer(),
              loginData(),
              login(),
              Visibility(
                child: otherActionWithAccount(),
                visible: false,
              ),
              Spacer(),
              Visibility(
                child: loginWithGoogleOrFaceboook(),
                visible: false,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Spacer(),
              loginData(),
              login(),
              otherActionWithAccount(),
              Spacer(),
              loginWithGoogleOrFaceboook(),
            ],
          ),
        ),
      );
    }
  }
}

class loginData extends StatelessWidget {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(left: 30.0, top: 30, bottom: 30),
              alignment: Alignment.bottomLeft,
              child: NameApp(
                isKey: false,
              )),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextFormField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.message),
                border: UnderlineInputBorder(),
                labelText: 'Enter your email',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.lock),
                border: UnderlineInputBorder(),
                labelText: 'Enter your password',
              ),
            ),
          ),
        ]);
  }
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  log("Rozmiar" +
                      MediaQuery.of(context).viewInsets.bottom.toString());
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Color(0xffffffff)),
                  backgroundColor: MaterialStateProperty.all(Color(0xff1184EF)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  )),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            )),
      ],
    );
  }
}

class otherActionWithAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "CREATE NEW \n ACCOUNT",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          textAlign: TextAlign.center,
        ),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("----------"),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ButtonWhiteWithBorder(
                  text: "I FORGOT MY PASSWORD",
                  borderColor: const Color(0xff3B5999),
                ),
              ),
              Text("----------")
            ],
          ),
        ),

        // Expanded(flex: 1,child:
        // const Spacer(),
        // ),
      ],
    );
  }
}

class loginWithGoogleOrFaceboook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: ButtonWithImage(
                    text: "GOOGLE",
                    imageAsset: "assets/google_icon.png",
                    color: const Color(0xffFF3333)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: ButtonWithImage(
                    text: "FACEBOOK",
                    imageAsset: "assets/facebook_icon.png",
                    color: const Color(0xff3B5999)),
              ),
            )
          ],
        ));
  }
}

class BigAppLogo extends StatelessWidget {
  static const logoMarginTop = 150.0;
  static const imageDimension = 250.0;

  const BigAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(ImageResources.logoApp),
      width: imageDimension,
      height: imageDimension,
    );
  }
}

class NameApp extends StatelessWidget {
  static const letterSpacingInNameApp = 0.5;
  static const nameAppFontSize = 30.0;
  static const nameAppNameMargin = 20.0;
  late bool isKeyboardShow;

  NameApp({super.key, bool isKey = false}) {
    isKeyboardShow = isKey;
  }

  @override
  Widget build(BuildContext context) {
    log("BUDUJE NAZWE APLIKACJI");

    return Text(
      TextResources.nameApp,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
            color: MainAppStyle.mainColorApp,
            letterSpacing: letterSpacingInNameApp,
            fontSize: nameAppFontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ButtonWithImage extends StatelessWidget {
  late String textButton;
  late String imageButton;
  late Color colorBackground;

  ButtonWithImage(
      {required String text,
      required String imageAsset,
      required Color color,
      super.key}) {
    textButton = text;
    imageButton = imageAsset;
    colorBackground = color;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: ImageIcon(
        AssetImage(imageButton),
        color: null,
      ),
      label: Text(textButton), // <-- Text
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
          backgroundColor: colorBackground,
          foregroundColor: Color(0xffffffff),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }
}

class ButtonWhiteWithBorder extends StatelessWidget {
  late String textButton;

  late Color colorBackground;

  ButtonWhiteWithBorder(
      {required String text, required Color borderColor, super.key}) {
    textButton = text;
    colorBackground = borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: null,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        // Set this
        padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        side: MaterialStateProperty.all(
            BorderSide(width: 1.0, color: Color(0xff1184EF))),
        textStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 9.0, color: const Color(0xff000000))),
      ),
      child: Text(textButton),
    );
  }
}
