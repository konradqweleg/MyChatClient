import 'package:flutter/material.dart';

class ButtonWithImage extends StatelessWidget {
  final String text;
  final String image;
  final Color backgroundColor;

  const ButtonWithImage(
      {required this.text,
      required this.image,
      required this.backgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: ImageIcon(
        AssetImage(image),
        color: null,
      ),
      label: Text(text), // <-- Text
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
