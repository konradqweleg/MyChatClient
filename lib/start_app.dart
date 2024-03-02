import 'package:flutter/material.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'database/di_db/di_db_service_sqlite.dart';
import 'di/register_di.dart';
import 'navigation/page_route_navigation.dart';
import 'login_and_registration/login/login.dart';
import 'common/big_app_logo.dart';
import 'common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  RegisterDI.register(DiDbServiceSqlite());
  runApp(

    const App()
  );
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
     title: "MY CHAT",
     localizationsDelegates: AppLocalizations.localizationsDelegates,
     supportedLocales: AppLocalizations.supportedLocales,
     theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: MainAppStyle.mainColorApp),
       useMaterial3: true,
     ),
     home: const Scaffold(body: StartPanel()),
   );
  }

}


class StartPanel extends StatefulWidget {
  const StartPanel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartPanelState();
  }
}

class _StartPanelState extends State<StartPanel> {
  @override
  void initState() {
    super.initState();

    PageRouteNavigation.navigationTransitionSlideFromDown(
      context: context,
      destination: const Login(),
      delayInSeconds: 1,
      isClearBackStack: true
    );
  }

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
            padding: MainAppStyle.defaultMainPadding,
            child: const NameApp(),
          ),
        ],
      ),
    );
  }
}
