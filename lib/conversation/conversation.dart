import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/conversation/requests/request_get_messages_with_friend.dart';
import 'package:my_chat_client/conversation/send_message_widget.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';

import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';
import '../common/undo_button.dart';
import '../database/db_services/friends/friends_service.dart';
import '../database/db_services/info_about_me/info_about_me_service.dart';
import '../database/model/friend.dart';
import '../database/model/message.dart';
import '../login_and_registration/common/result.dart';
import '../main_conversations_list/requests/message_data.dart';
import '../style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'conversation_friend_icon.dart';
import 'message_view.dart';
import 'package:intl/intl.dart';
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
  String friendSurname = "";

  Timer? _timer;
  ScrollController _scrollController = ScrollController();

  @override dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 45), (_) {
      downloadMessageWithFriends();



    });



  }

  Future<void> readFriendNameFromId(int id)  async {
   List<Friend> friendsFromDb = await getIt<FriendsService>().getFriends();
    setState(() {

      List<Friend> friendWithMatchId = friendsFromDb.where((element) => element.idFriend == id).toList();
      friendName = friendWithMatchId.isNotEmpty ? friendWithMatchId.first.name : "";
      friendSurname = friendWithMatchId.isNotEmpty ? friendWithMatchId.first.surname : "";

    });

    return Future.value();
  }

  Future<void> readMessagesWithFriends(int id) async {
    List<Message> friendsFromDb = await getIt<MessagesService>().getMessagesWithFriendId(id);
    int idUser = await getIt<InfoAboutMeService>().getId();

    List<MessageOnViewData> newMessages = friendsFromDb
        .map((e) => MessageOnViewData(
        message: e.message, isMessageFromFromFriend: e.idSender != idUser))
        .toList();

    List<MessageOnViewData> updatedMessages = newMessages.where((newMessage) {
      return !messages.any((oldMessage) =>
      oldMessage.message == newMessage.message &&
          oldMessage.isMessageFromFromFriend == newMessage.isMessageFromFromFriend);
    }).toList();

    if (updatedMessages.isNotEmpty) {
      setState(() {
        messages.addAll(updatedMessages);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      });
    }
  }

  Future<void> downloadMessageWithFriends() async {
    int idUser = await getIt<InfoAboutMeService>().getId();
    Result lastMessages = await getIt<RequestGetMessagesWithFriend>().getMessagesWithFriend(idUser,widget.idFriend);

    if(lastMessages.isError()) {
      return;
    }

    var listConversationsRawData = jsonDecode(lastMessages.data as String) as List;
    List<MessageData> lastMessagesWithFriends = listConversationsRawData.map((tagJson) => MessageData.fromMap(tagJson)).toList();

    int timestamp = 1633024862000;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date);

    await getIt<MessagesService>().addMessagesWhenNoExists(lastMessagesWithFriends.map((e) => Message(idMessage: e.idMessage, idSender: e.idSender, idReceiver: e.idReceiver, message: e.message, date: formattedDate)).toList());


     await  readMessagesWithFriends(widget.idFriend);

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent+75,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );




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
                      friendName +" "+ friendSurname,
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
                      controller: _scrollController,
                      child: Column(
                        children: createMessageWidgetWithAlignment(messages),

                      ),
                    ),
                  ),
                ),
              ),
               SendMessageWidget(idFriend: widget.idFriend,updateMessages: downloadMessageWithFriends,)
            ],
          )),
    );
  }
}
