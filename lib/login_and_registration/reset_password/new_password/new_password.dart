import 'package:flutter/material.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/change_password_on_server.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password_form.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password_http.dart';
import '../../../common/exit_button.dart';
import '../../../navigation/page_route_navigation.dart';
import '../../../style/main_style.dart';
import '../../login/login.dart';

void main() => runApp( NewPassword("emptyEmail","emptyCode"));


class NewPassword extends StatefulWidget {
   NewPassword(this.emailUser,this.resetPasswordCode, {super.key});

  String emailUser;
  String resetPasswordCode;

  @override
  State<StatefulWidget> createState() {
    return _NewPasswordState();
  }
}

class _NewPasswordState extends State<NewPassword> {

  void _backToLogin(BuildContext context){
    PageRouteNavigation.navigation(context: context,destination: const Login());
  }

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
                      child: ExitButton(action: ()=>_backToLogin(context))
                  )
                  ,
                  Container(
                    // Another fixed-height child.
                    height: 300.0,
                    alignment: Alignment.topLeft,
                    child:  NewPasswordForm(widget.emailUser,widget.resetPasswordCode,RequestChangePasswordHttp()),
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


