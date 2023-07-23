import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/text_resources.dart';
import '../style/main_style.dart';

class NameApp extends StatelessWidget {
  static const letterSpacingInNameApp = 0.5;
  static const nameAppFontSize = 30.0;
  static const nameAppNameMargin = 20.0;

  const NameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      TextResources.nameApp,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
            color: Color(MainAppStyle.mainColorApp),
            letterSpacing: letterSpacingInNameApp,
            fontSize: nameAppFontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}