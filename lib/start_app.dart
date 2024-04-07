import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:window_manager/window_manager.dart';
import 'database/db_services/info_about_me/info_about_me_service.dart';
import 'di/register_di.dart';
import 'login_and_registration/login/request/request_is_correct_tokens.dart';
import 'main_conversations_list/main_conversation_list.dart';
import 'navigation/page_route_navigation.dart';
import 'login_and_registration/login/login.dart';
import 'common/big_app_logo.dart';
import 'common/name_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> setMinWidthAndHeightForWindows() async {

  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(550, 900));
    WindowManager.instance.setMaximumSize(const Size(550, 900));
  }
}



Future<void> main() async {
  RegisterDI registerDI = RegisterDI(DiFactoryImpl());
  registerDI.register();

  await setMinWidthAndHeightForWindows();

  runApp(const App());
}

class App extends StatelessWidget {
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
  final GetIt _getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _redirectToSuitablePage();
  }

  Future<void> _redirectToSuitablePage() async {
    bool isAlreadySavedDataAboutUser = await _getIt<InfoAboutMeService>().isInfoAboutMeExist();

    if (isAlreadySavedDataAboutUser) {
      _getIt<RequestIsCorrectTokens>().isCorrectSavedTokens().then((isValidTokens) {
        if (isValidTokens) {
          _redirectToMainConversationView();
        }
      });
    }else{
      _redirectToLoginView();
    }

  }

  void _redirectToLoginView() {
    PageRouteNavigation.navigationTransitionSlideFromDown(
        context: context,
        destination: Login(),
        delayInSeconds: 1,
        isClearBackStack: true);
  }

  void _redirectToMainConversationView() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainConversationList()),
    // );
    //
    PageRouteNavigation.navigationTransitionSlideFromDown(
        context: context,
        destination: MainConversationList(),
        delayInSeconds: 1,
        isClearBackStack: true);
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
