import 'package:flutter/material.dart';
import '../style/main_style.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key,required this.action});
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: const Icon(
        Icons.close,
        color: MainAppStyle.darkMainColorApp,
      ),
    );
  }
}
