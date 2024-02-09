import 'package:flutter/material.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/list_conversations.dart';
import 'package:my_chat_client/main_conversations_list/search_bar/search_person_and_message.dart';

import '../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
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
      home: const Scaffold(body: MainConversationList()),
    );
  }
}

class MainConversationList extends StatefulWidget {
  const MainConversationList({super.key});

  @override
  State<MainConversationList> createState() => _MainConversationListState();
}

class _MainConversationListState extends State<MainConversationList> {
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Messages",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
              SizedBox(
                  height: MediaQuery.of(context).size.height - 165,
                  child: ListConversations())
            ],
          )),
    );
  }
}
