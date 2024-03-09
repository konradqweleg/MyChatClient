import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';

import 'package:my_chat_client/main_conversations_list/list_friends/user_my_chat.dart';
import 'package:my_chat_client/main_conversations_list/requests/last_messages_with_friends_data.dart';

import '../../database/model/friend.dart';
import '../../database/model/message.dart';
import '../../login_and_registration/common/result.dart';
import '../one_person/one_person_widget.dart';
import '../requests/request_last_message.dart';

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
    _showAllFriends();
    _downloadLastMessagesWithFriends();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {

      _downloadLastMessagesWithFriends();
      _showAllFriends();

    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _showAllFriends() async {
    setState(() {
      friendsConversations.clear();
    });

    List<Friend> friendsFromDb = await getIt<FriendsService>().getFriends();
    for (var friend in friendsFromDb) {
      Message friendLastMessage = await getIt<MessagesService>().getLastMessageWithFriendId(friend.idFriend);
      setState(() {
        friendsConversations.add(UserMyChat("${friend.name} ${friend.surname}", friendLastMessage.message, friend.idFriend));
      });
    }

  }

  Future<void> _downloadLastMessagesWithFriends() async {
    int idUser = await getIt<InfoAboutMeService>().getId();
    Result lastMessages = await getIt<RequestLastMessage>().getLastMessagesWithFriendsForUserAboutId(idUser);

    if(lastMessages.isError()) {
      return;
    }

    var listConversationsRawData = jsonDecode(lastMessages.data as String) as List;
    List<LastMessageWithFriendsData> lastMessagesWithFriends = listConversationsRawData.map((tagJson) => LastMessageWithFriendsData.fromMap(tagJson)).toList();

    for(var element in lastMessagesWithFriends) {
      await getIt<MessagesService>().addMessage(Message(idMessage: element.idMessage, message: element.lastMessage, idSender: element.idSender, idReceiver: element.idReceiver, date: element.date));
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
