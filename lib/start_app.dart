import 'package:flutter/material.dart';
import 'package:my_chat_client/resources/text_resources.dart';
import 'animations/PageRouteTransition.dart';
import 'login_and_registration/login/login.dart';
import 'main_app_resources/logo.dart';
import 'main_app_resources/name_app.dart';




void main() {
  runApp(
    MaterialApp(
      title: TextResources.nameApp,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Login()),
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
    super.initState();
    PageRouteTransition.transitionAfterDelay(
        context: context, destination:  Login()
    );
  }

  @override
  Widget build(BuildContext context) {
    return const StartAppView();
  }
}

class StartAppView extends StatelessWidget {
  const StartAppView({super.key});

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
            child: NameApp(),
          ),
        ],
      ),
    );
  }
}
