import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const Icon(Icons.arrow_back),
    );
  }
}
