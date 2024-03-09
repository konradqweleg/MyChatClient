import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:my_chat_client/tokens/token_manager_factory.dart';

import 'database/db_services/friends/friends_service.dart';
import 'database/model/friend.dart';
import 'di/register_di.dart';
import 'navigation/page_route_navigation.dart';
import 'login_and_registration/login/login.dart';
import 'common/big_app_logo.dart';
import 'common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  RegisterDI registerDI = RegisterDI(DiFactoryImpl());
  registerDI.register();



  runApp(
    const App()
  );
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {


    final GetIt _getIt = GetIt.instance;
     // _getIt<FriendsService>().removeFriend(Friend( idFriend: 772, name: 'addasfadsf', surname: 'dasfadsf'));
     // _getIt<FriendsService>().removeFriend(Friend( idFriend: 774, name: 'sadsf', surname: 'dsafdsaf'));
     // _getIt<FriendsService>().removeFriend(Friend( idFriend: 779, name: 'Konrad', surname: 'Groń'));
     // _getIt<FriendsService>().removeFriend(Friend( idFriend: 773, name: 'asdasda', surname: 'asdfasd'));

    //
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 772, name: 'asd', surname: 'sadsadasa'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 774, name: 'sadsf', surname: 'dsafdsaf'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 773, name: 'asdasda', surname: 'asdfasd'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 775, name: 'Konrad', surname: 'Groń'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 776, name: 'Konrad', surname: 'Groń'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 777, name: 'Konrad', surname: 'Groń'));
    // _getIt<FriendsService>().addFriend(Friend( idFriend: 778, name: 'Konrad', surname: 'Groń'));


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
      destination:  Login(),
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
