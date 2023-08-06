import 'package:flutter/material.dart';

import '../../../navigation/page_route_navigation.dart';
import '../../register/register.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateNewAccountState();
  }
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () {
          PageRouteNavigation.navigationTransitionSlideFromDown(
            context: context,
            destination: const Register(),
          );
        },
        child: const Text(
          "CREATE NEW \n ACCOUNT",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
