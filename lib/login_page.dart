import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_chat_client/resources/image_resources.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/resources/text_resources.dart';
import 'animations/PageRouteTransition.dart';
import 'login.dart';

void main() {
  runApp(
      const Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(body:MainPanel())
  ));
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
            child:  NameApp(),
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

