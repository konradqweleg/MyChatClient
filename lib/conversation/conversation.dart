import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/conversation/send_message_widget.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/database/model/info_about_me.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';
import '../common/undo_button.dart';
import '../database/db_services/friends/friends_service.dart';
import '../database/db_services/info_about_me/info_about_me_service.dart';
import '../database/model/friend.dart';
import '../database/model/message.dart';
import '../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'conversation_friend_icon.dart';
import 'message_view.dart';

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
      home: Scaffold(
          body: Conversation(
        idFriend: 1,
      )),
    );
  }
}

class Conversation extends StatefulWidget {
  int idFriend;

  Conversation({super.key, required this.idFriend});

  @override
  State<Conversation> createState() => _ConversationState();
}

class MessageOnViewData {
  String message;
  bool isMessageFromFromFriend;

  MessageOnViewData(
      {required this.message, required this.isMessageFromFromFriend});
}

class _ConversationState extends State<Conversation> {
  List<MessageOnViewData> messages = [];
  GetIt getIt = GetIt.instance;
  String friendName = "";

  Future<void> readFriendNameFromId(int id)  async {
   List<Friend> friendsFromDb = await getIt<FriendsService>().getFriends();
    setState(() {

      List<Friend> friendWithMatchId = friendsFromDb.where((element) => element.idFriend == id).toList();
      friendName = friendWithMatchId.isNotEmpty ? friendWithMatchId.first.name : "";

    });

    return Future.value();
  }

  Future<void> readMessagesWithFriends(int id) async {
    List<Message> friendsFromDb = await getIt<MessagesService>().getMessagesWithFriendId(id);
    int idUser = await getIt<InfoAboutMeService>().getId();
    setState(() {
      messages = friendsFromDb
          .map((e) => MessageOnViewData(
              message: e.message, isMessageFromFromFriend: e.idSender != idUser))
          .toList();
      // messages = List<MessageOnViewData>.generate(
      //     10,
      //     (index) => MessageOnViewData(
      //         message: "lorem ipsum", isMessageFromFromFriend: true));
    });
  }

  List<Widget> createMessageWidgetWithAlignment(
      List<MessageOnViewData> messages) {
    List<Widget> messageView = messages
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: e.isMessageFromFromFriend
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: MessageView(
                  isMessageFromFromFriend: e.isMessageFromFromFriend,
                  message: e.message,
                ),
              ),
            ))
        .toList();

    if (messageView.isEmpty) {
      return [Container()];
    }

    return messageView;
  }

  @override
  Widget build(BuildContext context) {
    readMessagesWithFriends(widget.idFriend);
    readFriendNameFromId(widget.idFriend);
    return Scaffold(
      appBar: null,
      backgroundColor: MainAppStyle.mainColorApp,
      body: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8.0,
                            bottom: MediaQuery.of(context).padding.top + 10),
                        child: Container(
                            height: 20,
                            alignment: Alignment.topLeft,
                            child: UndoButton(
                              color: Colors.white,
                            )),
                      ),
                      Expanded(child: Container()), // Empty Expanded widget
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ConversationFriendIcon(
                      friendName,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, // Set the background color to red
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(30), // Round the top left corner
                        topRight:
                            Radius.circular(30), // Round the top right corner
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: createMessageWidgetWithAlignment(messages),

                      ),
                    ),
                  ),
                ),
              ),
              const SendMessageWidget()
            ],
          )),
    );
  }
}
