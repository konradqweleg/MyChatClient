import 'package:flutter/material.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';

import 'package:my_chat_client/main_conversations_list/search_bar/search_person_and_message.dart';
import '../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'list_conversations/list_conversations.dart';

void main() {
  RegisterDI registerDI = RegisterDI(DiFactoryImpl());
  registerDI.register();

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
      home: const Scaffold(body: ConversationsList()),
    );
  }
}

class ConversationsList extends StatefulWidget {
  const ConversationsList({super.key});

  @override
  State<ConversationsList> createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
          child: Column(
            children: [
              const SearchPersonAndMessage(),
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.messages,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
               Expanded(child: ConversationsWidget(refreshTime: const Duration(seconds: 5),))
            ],
          )),
    );
  }
}
