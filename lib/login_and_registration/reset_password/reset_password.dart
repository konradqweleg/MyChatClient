import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/check_exists_email_http.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/is_correct_password_code_http.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/requests/send_reset_password_code_http.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/reset_code_on_server.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password_form.dart';
import 'package:my_chat_client/login_and_registration/reset_password/check/validate_code_on_server.dart';
import '../../common/undo_button.dart';
import '../../style/main_style.dart';

void main() => runApp(const ResetPassword());

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordState();
  }
}

class _ResetPasswordState extends State<ResetPassword> {
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
                      child:  ResetPasswordForm(ResetCodeOnServer(),IsCorrectPasswordCodeHttp(),SendResetPasswordCodeHttp()),
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
