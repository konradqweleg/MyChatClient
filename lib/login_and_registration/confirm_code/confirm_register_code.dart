import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_code_form.dart';
import 'package:my_chat_client/login_and_registration/register/register_form.dart';
import '../../main_app_resources/undo_button.dart';
import '../../style/main_style.dart';

void main() => runApp(const ConfirmRegisterCode());


class ConfirmRegisterCode extends StatefulWidget {
  const ConfirmRegisterCode({super.key});

  @override
  State<StatefulWidget> createState() {
    return ConfirmRegisterCodeState();
  }
}

class ConfirmRegisterCodeState extends State<ConfirmRegisterCode> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  const SizedBox(height: 25),
                  Container(
                      height: 20,
                      alignment: Alignment.topLeft,
                      child: UndoButton()
                  )
                  ,
                  Container(
                    // Another fixed-height child.
                    height: 600.0,
                    alignment: Alignment.topLeft,
                    child: const ConfirmCodeForm(),
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


