import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:my_chat_client/resources/text_resources.dart';

import '../login.dart';

void main() {
  runApp(MaterialApp(
    title: TextResources.nameApp,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
    home: const Scaffold(
      body: LoginVisibilityManager(),
    ),
  ));
}

class LoginVisibilityManager extends StatelessWidget {
  const LoginVisibilityManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyboardVisibilityProvider(
      child: Login(),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
//'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Visibility(
            visible: !isKeyboardVisible,
            child: Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.all(20.0),
                child: NameApp(),
              ),
            )),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.only(left: 20.0, right: 20),
            child: LoginForm(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20.0, right: 20),
            child: LoginButton(),
          ),
        ),
        Visibility(
            visible: !isKeyboardVisible,
            child: Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: otherActionWithAccount(),
              ),
            )),
        Visibility(
            visible: !isKeyboardVisible,
            child: Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.all(20.0),
                child: loginWithGoogleOrFaceboook(),
              ),
            ))
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //return Placeholder();
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                // A fixed-height child.
                alignment: Alignment.topLeft,
                child:  NameApp(),
              ),
              SizedBox(height: 20,),
              Container(
                height: 80,
                child: TextFormField(
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.message),
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                ),
              ),
              Container(
                height: 80,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                ),
              ),
              SizedBox(height: 10,),
              LoginButton()
            ],
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
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
