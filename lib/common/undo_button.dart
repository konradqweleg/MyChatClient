import 'package:flutter/material.dart';
import '../style/main_style.dart';

class UndoButton extends StatelessWidget {

  Color? color;

  UndoButton({super.key, this.color = MainAppStyle.darkMainColorApp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child:  Icon(
        Icons.arrow_back,
        color: color,
      ),
    );
  }
}
