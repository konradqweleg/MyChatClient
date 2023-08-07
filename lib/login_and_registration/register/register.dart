import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/register/register_form.dart';
import '../../common/undo_button.dart';
import '../../style/main_style.dart';

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
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: MainAppStyle.defaultMainPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Container(
                        height: 20,
                        alignment: Alignment.topLeft,
                        child: const UndoButton()),
                    Container(
                      // Another fixed-height child.
                      height: 600.0,
                      alignment: Alignment.topLeft,
                      child: const RegisterForm(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
