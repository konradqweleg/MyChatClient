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
  bool isMessageFromFriend;
  int idMessage;

  MessageOnViewData(
      {required this.message, required this.isMessageFromFriend,required this.idMessage});
}

class _ConversationState extends State<Conversation> {
  final List<MessageOnViewData> _messages = [];
  final GetIt _getIt = GetIt.instance;
  String _friendName = "";
  String _friendSurname = "";
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  final Duration refreshMessagesDuration = const Duration(seconds: 45);
  final Duration scrollDurationToEndConversationInMilliseconds = const Duration(milliseconds: 300);

  @override dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override initState() {
    super.initState();
   _initTimerDownloadMessages();

  }

  void _initTimerDownloadMessages() {
    _timer = Timer.periodic(refreshMessagesDuration, (_) {
      _downloadMessageWithFriends();
    });
  }


  Future<void> _readFriendNameFromId(int id)  async {
   List<Friend> allFriendsInLocalDatabase = await _getIt<FriendsService>().getFriends();
    setState(() {
      List<Friend> friendWithMatchId = allFriendsInLocalDatabase.where((element) => element.idFriend == id).toList();
      _friendName = friendWithMatchId.isNotEmpty ? friendWithMatchId.first.name : "";
      _friendSurname = friendWithMatchId.isNotEmpty ? friendWithMatchId.first.surname : "";

    });

    return Future.value();
  }

  Future<void> _readMessagesWithFriendsFromDbToView(int id) async {
    List<Message> messageWithFriend = await _getIt<MessagesService>().getMessagesWithFriendId(id);
    int idUser = await _getIt<InfoAboutMeService>().getId();

    List<MessageOnViewData> messagesOnViewWithFriends = messageWithFriend
        .map((e) => MessageOnViewData(message: e.message, isMessageFromFriend: e.idSender != idUser,idMessage: e.idMessage))
        .toList();

    List<MessageOnViewData> newMessagesNoExistsOnViewAlready = messagesOnViewWithFriends.where((newMessage) {
      return !_messages.any((oldMessage) =>
      oldMessage.message == newMessage.message &&
          oldMessage.idMessage == newMessage.idMessage);
    }).toList();

    if (newMessagesNoExistsOnViewAlready.isNotEmpty) {
      setState(() {
        _messages.addAll(newMessagesNoExistsOnViewAlready);
        _scrollToEndConversation();
      });
    }
  }

  void _scrollToEndConversation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: scrollDurationToEndConversationInMilliseconds,
        curve: Curves.easeOut,
      );
    });
  }

  String _convertTimestampToFormattedDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('yyyy-MM-dd – kk:mm').format(date);
  }



  Future<Result> _downloadMessageViaHttp() async {
    int idUser = await _getIt<InfoAboutMeService>().getId();
    Result lastMessages = await _getIt<RequestGetMessagesWithFriend>().getMessagesWithFriend(idUser,widget.idFriend);
    return lastMessages;
  }

  List<MessageData> _convertRawMessagesToMessageData(Result lastMessages) {
    var listConversationsRawData = jsonDecode(lastMessages.data as String) as List;
    List<MessageData> lastMessagesWithFriends = listConversationsRawData.map((tagJson) => MessageData.fromMap(tagJson)).toList();
    return lastMessagesWithFriends;
  }

  Future<void> _addDownloadedMessagesToDb(List<MessageData> lastMessagesWithFriends) async {
    await _getIt<MessagesService>().addMessagesWhenNoExists(lastMessagesWithFriends.map((e) => Message(idMessage: e.idMessage, idSender: e.idSender, idReceiver: e.idReceiver, message: e.message, date: _convertTimestampToFormattedDate(e.dateTimeMessage))).toList());
  }

  Future<void> _downloadMessageWithFriends() async {
    Result lastMessages = await _downloadMessageViaHttp();

    if(lastMessages.isError()) {
      return;
    }

    List<MessageData> lastMessagesWithFriends = _convertRawMessagesToMessageData(lastMessages);
    await _addDownloadedMessagesToDb(lastMessagesWithFriends);
    await  _readMessagesWithFriendsFromDbToView(widget.idFriend);
    _scrollToEndConversation();
  }

  List<Widget> _createMessageWidgetWithAlignment(
      List<MessageOnViewData> messages) {
    List<Widget> messageView = messages
        .map((e) => Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: e.isMessageFromFriend
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: MessageView(
                  isMessageFromFromFriend: e.isMessageFromFriend,
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
    _readMessagesWithFriendsFromDbToView(widget.idFriend);
    _readFriendNameFromId(widget.idFriend);
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
                      "$_friendName $_friendSurname",
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
                        children: _createMessageWidgetWithAlignment(_messages),

                      ),
                    ),
                  ),
                ),
              ),
               SendMessageWidget(idFriend: widget.idFriend,updateMessages: _downloadMessageWithFriends,)
            ],
          )),
    );
  }
}
