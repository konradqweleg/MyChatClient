import 'package:flutter/material.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/check_confirm_code_on_server.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_code_register_form.dart';
import '../../navigation/page_route_navigation.dart';
import '../../style/main_style.dart';
import '../login/login.dart';
import '../register/user_register_data.dart';
import 'validate_confirm_code.dart';

void main() => runApp(ConfirmRegisterCode(UserRegisterData("","","","")));

class ConfirmRegisterCode extends StatefulWidget {
  UserRegisterData userRegisterData;
  ValidateConfirmCode checkConfirmCode = ValidateConfirmCodeOnServer();

  ConfirmRegisterCode( this.userRegisterData,{super.key});

  @override
  State<StatefulWidget> createState() {
    return _ConfirmRegisterCodeState();
  }
}

class _ConfirmRegisterCodeState extends State<ConfirmRegisterCode> {

  void _backToLogin(BuildContext context){
    PageRouteNavigation.navigation(context: context,destination: const Login());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Material(
          child: SingleChildScrollView(
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
                        child: ExitButton(action: ()=>_backToLogin(context),)
                    )
                    ,
                    Container(
                      height: 650.0,
                      alignment: Alignment.topLeft,
                      child:  ConfirmCodeRegisterForm(widget.userRegisterData,ValidateConfirmCodeOnServer()),
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


