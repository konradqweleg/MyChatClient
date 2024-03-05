import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';

import 'package:my_chat_client/main_conversations_list/list_friends/user_my_chat.dart';
import 'package:my_chat_client/main_conversations_list/requests/LastMessagesWithFriendsData.dart';

import '../../database/model/friend.dart';
import '../../database/model/message.dart';
import '../../login_and_registration/common/result.dart';
import '../one_person/one_person_widget.dart';
import '../requests/RequestLastMessage.dart';

class ListConversations extends StatefulWidget {
  const ListConversations({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListConversationsState();
  }
}
class ListConversationsState extends State<ListConversations> {
  GetIt getIt = GetIt.instance;
  Timer? _timer;

  List<UserMyChat> friendsConversations = [];
  List<OnePersonWidget> friendsConversationsWidget = [];

  @override
  void initState() {
    super.initState();
    _getFriends();
    _downloadLastMessages();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {

      _downloadLastMessages();
      _getFriends();
        print('Timer executed');

    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _getFriends() async {
    List<Friend> data = await getIt<FriendsService>().getFriends();
    for (var element in data) {
      Message lastMessage = await getIt<MessagesService>().getLastMessageWithFriendId(element.idFriend);
      setState(() {
        friendsConversations.clear();
        friendsConversations.add(UserMyChat("${element.name} ${element.surname}", lastMessage.message, element.idFriend));
      });
    }
  }

  Future<void> _downloadLastMessages() async {
    int data = await getIt<InfoAboutMeService>().getId();
    Result lastMessages = await getIt<RequestLastMessage>().getLastMessagesWithFriends(data);

    if(lastMessages.isError()) {
      return;
    }

    var tagObjsJson = jsonDecode(lastMessages.data as String) as List;
    List<LastMessageWithFriendsData> tagObjs = tagObjsJson.map((tagJson) => LastMessageWithFriendsData.fromMap(tagJson)).toList();
    for(var element in tagObjs) {
      print(element);
      await getIt<MessagesService>().addMessage(Message(idMessage: element.idMessage, message: element.lastMessage, idSender: element.idUser, idReceiver: element.idUser, date: element.date));
    }
  }

  String _trimText(String text) {
    const int maxMessageLength = 50;
    if(text.length > maxMessageLength) {
      return "${text.substring(0,maxMessageLength)}...";
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    // Transformuj friendsConversations do friendsConversationsWidget
    friendsConversationsWidget = friendsConversations.map((user) => OnePersonWidget(Colors.blue, user.name, _trimText(user.lastMessage))).toList();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: friendsConversationsWidget,
              ),
            ),
          ),
        );
      },
    );
  }
}
