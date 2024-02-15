import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/user_my_chat.dart';

import '../../database/model/friend.dart';
import '../../database/model/message.dart';
import '../one_person/one_person_widget.dart';

class ListConversations extends StatefulWidget {
  const ListConversations({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListConversationsState();
  }
}

class ListConversationsState extends State<ListConversations> {
  GetIt getIt = GetIt.instance;

@override initState() {
   super.initState();
    _getFriends();
  }

void _getFriends() async {
      List<Friend> data = await getIt<FriendsService>().getFriends();
      for (var element in data) {
        Message lastMessage = await getIt<MessagesService>().getLastMessageWithFriendId(element.idFriend);
        setState(() {
          friendsConversations.add(UserMyChat("${element.name} ${element.surname}", lastMessage.message, element.idFriend));
        });
      }
}



  List<UserMyChat> friendsConversations = [
    UserMyChat("Konrad Groń","Ostatnio w twojej sprawie nie było dobrze",1),
    UserMyChat("Damian Golonka","Ale to nie jest tak że ten PVM nie chce działać to po prostu kod jest zły",1),
    UserMyChat("Mateusz Rysula","Wiesz on mi ostatnio powiedział że to bez sensu",1),
    UserMyChat("Andrzej Sroka","Przegraliśmy",1),
    UserMyChat("Kamil Kowalski","Wiesz on mi ostatnio powiedział że to bez sensu",1),
    UserMyChat("Jakub Kowalski","Ani nie dobrze ani źle",1),
    UserMyChat("Sebastian Pawlak","Polska wygrała",1,),
    UserMyChat("Sebastian Pawlak","Polska wygrała",1,),
    UserMyChat("Jan Nowak","Cześć, jak się masz?",2,),
    UserMyChat("Anna Kowalska","Dzisiaj jest piękny dzień",3,),
    UserMyChat("Piotr Zieliński","Czy możemy się spotkać?",4,),
    UserMyChat("Katarzyna Nowak","Mam nowy pomysł na projekt",5,),


  ];
  List<OnePersonWidget> friendsConversationsWidget = [];
  
  String _trimText(String text) {
    const int maxMessageLength = 50;
    if(text.length > maxMessageLength) {
      return "${text.substring(0,maxMessageLength)}...";
    }
    return text;
  }

  void _transformFriendsConversationsToWidget() {
    friendsConversationsWidget = friendsConversations.map((UserMyChat user) => OnePersonWidget(Colors.blue, user.name, _trimText(user.lastMessage))).toList();
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _transformFriendsConversationsToWidget();
    });

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

