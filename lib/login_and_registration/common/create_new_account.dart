import 'package:flutter/material.dart';

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
    return const SizedBox(
      height: 50,
      child: Text(
        "CREATE NEW \n ACCOUNT",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
