import 'package:flutter/material.dart';

import '../../animations/PageRouteTransition.dart';
import '../register/register.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateNewAccountState();
  }
}

class CreateNewAccountState extends State<CreateNewAccount> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () {
          PageRouteTransition.transitionAfterDelay(
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
