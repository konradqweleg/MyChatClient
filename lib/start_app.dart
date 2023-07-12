import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_chat_client/resources/image_resources.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/resources/text_resources.dart';
import 'PageRouteTransition.dart';
import 'login.dart';

void main() {
  runApp(
    MaterialApp(
      title: TextResources.nameApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const Scaffold(body: StartPanel()),
    ),
  );
}

class StartPanel extends StatefulWidget {
  const StartPanel({super.key});

  @override
  State<StatefulWidget> createState() {
    return StartPanelState();
  }
}

class StartPanelState extends State<StartPanel> {
  @override
  void initState() {
    PageRouteTransition.transitionAfterDelay(
        context: context, destination: const LoginPanel()
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MainPanel();
  }
}

//Placeholder fajnie pokazuje wielksoci
class MainPanel extends StatelessWidget {
  const MainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          const BigAppLogo(),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(20),
            child: const NameApp(),
          ),
        ],
      ),
    );
  }
}

class BigAppLogo extends StatelessWidget {
  static const imageDimension = 250.0;

  const BigAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage(ImageResources.logoApp),
      width: imageDimension,
      height: imageDimension,
    );
  }
}

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
