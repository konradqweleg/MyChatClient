
import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/common/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/common/reset_password.dart';
import 'package:my_chat_client/login_and_registration/login/other_form_login/login_with_google_or_facebook.dart';
import 'package:my_chat_client/login_and_registration/register/register_form.dart';
import '../../main_app_resources/undo_button.dart';
import '../../style/main_style.dart';
import '../login/login_form.dart';

void main() => runApp(const Register());


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
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

                const SizedBox(height: 25),
                Container(
                  height: 20,
                  alignment: Alignment.bottomLeft,
                  child: UndoButton()
                )
                ,
                  Container(
                    // Another fixed-height child.
                    height: 410.0,
                    alignment: Alignment.topLeft,
                    child: const RegisterForm(),
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


