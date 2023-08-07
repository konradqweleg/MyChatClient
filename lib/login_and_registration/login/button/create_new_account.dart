import 'package:flutter/material.dart';
import '../../../navigation/page_route_navigation.dart';
import '../../register/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateNewAccountButton extends StatefulWidget {
  const CreateNewAccountButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateNewAccountButtonState();
  }
}

class _CreateNewAccountButtonState extends State<CreateNewAccountButton> {


  void navigationToRegisterForm(){
    PageRouteNavigation.navigationTransitionSlideFromDown(
      context: context,
      destination: const Register(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: navigationToRegisterForm,
        child:  Text(
          AppLocalizations.of(context)!.createNewAccount,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
