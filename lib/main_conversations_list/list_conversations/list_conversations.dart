import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/main_conversations_list/list_conversations/user_my_chat.dart';

import 'package:my_chat_client/main_conversations_list/requests/last_messages_with_friends_data.dart';
import 'package:my_chat_client/main_conversations_list/utils/ListUtils.dart';

import '../../database/model/friend.dart';
import '../../database/model/message.dart';
import '../../login_and_registration/common/result.dart';
import '../one_person/one_person_widget.dart';
import '../requests/friend_data.dart';
import '../requests/request_get_user_friends.dart';
import '../requests/request_last_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConversationsWidget extends StatefulWidget {
  ConversationsWidget({super.key, required this.refreshTime});

  Duration refreshTime;

  @override
  State<StatefulWidget> createState() {
    return ConversationsWidgetState();
  }
}

class ConversationsWidgetState extends State<ConversationsWidget> {
  GetIt getIt = GetIt.instance;
  Timer? _timer;

  List<UserMyChat> friendsConversations = [];
  List<OnePersonWidget> friendsConversationsWidget = [];

  ListUtils listUtils = ListUtils();

  @override
  void initState() {
    super.initState();
    _downloadLastMessagesWithFriends();
    _downloadUserFriends();
    _updateLastMessagesWithFriendsEveryMinutes();
    _updateFriendsListView();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _updateLastMessagesWithFriendsEveryMinutes() {
    _timer = Timer.periodic(widget.refreshTime, (_) {
      _downloadLastMessagesWithFriends();
      _downloadUserFriends();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _updateFriendsListView() async {
    List<Friend> friendsFromDb = await getIt<FriendsService>().getFriends();


    List<UserMyChat> potentialUpdatedFriendsConversations = [];
    for (var friend in friendsFromDb) {
      Message? friendLastMessage = await getIt<MessagesService>()
          .getLastMessageWithFriendId(friend.idFriend);
      setState(() {
        if (friendLastMessage != null) {
          potentialUpdatedFriendsConversations.add(UserMyChat(
              "${friend.name.trim()} ${friend.surname.trim()}",
              friendLastMessage.message,
              friend.idFriend));
        } else {
          potentialUpdatedFriendsConversations.add(UserMyChat(
              "${friend.name.trim()} ${friend.surname.trim()}",
              AppLocalizations.of(context)!.noMessages,
              friend.idFriend));
        }
      });
    }

    if (!listUtils.isEqualsAllListElements(
        potentialUpdatedFriendsConversations, friendsConversations)) {
      setState(() {
        friendsConversations.clear();
        friendsConversations.addAll(potentialUpdatedFriendsConversations);
      });
    }
  }

  Future<void> _downloadUserFriends() async {
    int idUser = await getIt<InfoAboutMeService>().getId();
    Result userFriends =
        await getIt<RequestGetUserFriends>().getUserFriends(idUser);

    if (userFriends.isError()) {
      return;
    }

    var listFriendsRawData = jsonDecode(userFriends.data as String) as List;
    List<FriendData> friends = listFriendsRawData
        .map((tagJson) => FriendData.fromMap(tagJson))
        .toList();

    for (var friend in friends) {
      await getIt<FriendsService>().addFriendWhenNotExists(Friend(
          idFriend: friend.id, name: friend.name, surname: friend.surname));
    }

    _updateFriendsListView();
  }

  Future<void> _downloadLastMessagesWithFriends() async {
    int idUser = await getIt<InfoAboutMeService>().getId();
    Result lastMessages = await getIt<RequestLastMessage>()
        .getLastMessagesWithFriendsForUserAboutId(idUser);

    if (lastMessages.isError()) {
      return;
    }

    var listConversationsRawData =
        jsonDecode(lastMessages.data as String) as List;
    List<LastMessageWithFriendsData> lastMessagesWithFriends =
        listConversationsRawData
            .map((tagJson) => LastMessageWithFriendsData.fromMap(tagJson))
            .toList();

    for (var message in lastMessagesWithFriends) {
      await getIt<FriendsService>().addFriendWhenNotExists(Friend(
          idFriend: message.idFriend,
          name: message.name,
          surname: message.surname));
      await getIt<MessagesService>().addMessage(Message(
          idMessage: message.idMessage,
          message: message.lastMessage,
          idSender: message.idSender,
          idReceiver: message.idReceiver,
          date: message.date));
    }

    _updateFriendsListView();
  }

  String _trimText(String text) {
    const int maxMessageLength = 50;
    if (text.length > maxMessageLength) {
      return "${text.substring(0, maxMessageLength)}...";
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    friendsConversationsWidget = friendsConversations
        .map((user) => OnePersonWidget(
            Colors.blue, user.name, _trimText(user.lastMessage), user.idUser))
        .toList();

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
