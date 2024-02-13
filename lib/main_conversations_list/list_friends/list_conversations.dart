

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/user_my_chat.dart';

import '../../database/model/friend.dart';
import '../../database/model/message.dart';
import '../one_person/one_person.dart';

class ListConversations extends StatefulWidget {


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
 // getIt<FriendsService>().addFriend(Friend( idFriend: 2, name: 'Błazej', surname: 'Jasinski'));
 // getIt<MessagesService>().addMessage(Message(idMessage: 1, message: 'Cześć', date: DateTime.now().toString(), idSender: 1, idReceiver: 2));
      List<Friend> data = await getIt<FriendsService>().getFriends();
      for (var element in data) {
        Message lastMessage = await getIt<MessagesService>().getLastMessageWithFriendId(element.idFriend);
        setState(() {
          friendsConversations.add(UserMyChat(element.name + " " + element.surname, lastMessage.message, "1"));
        });
       // friendsConversations.add(UserMyChat(element.name + " " + element.surname, lastMessage.message, "1"));
      }
}



    // getIt<FriendsService>().addFriend(Friend( idFriend: 1, name: 'KonradX', surname: 'GrońX'));
    // List<Friend> data = await getIt<FriendsService>().getFriends();
    // for (var element in data) {
    //   friendsConversations.add(UserMyChat(element.name + " " + element.surname, "...", "1"));
    // }




  List<UserMyChat> friendsConversations = [
    UserMyChat("Konrad Groń","Ostatnio w twojej sprawie nie było dobrze","1"),
    UserMyChat("Damian Golonka","Ale to nie jest tak że ten PVM nie chce działać to po prostu kod jest zły","1"),
    UserMyChat("Mateusz Rysula","Wiesz on mi ostatnio powiedział że to bez sensu","1"),
    UserMyChat("Andrzej Sroka","Przegraliśmy","1"),
    UserMyChat("Kamil Kowalski","Wiesz on mi ostatnio powiedział że to bez sensu","1"),
    UserMyChat("Jakub Kowalski","Ani nie dobrze ani źle","1"),
    UserMyChat("Sebastian Pawlak","Polska wygrała","1",),
    UserMyChat("Sebastian Pawlak","Polska wygrała","1",),
    UserMyChat("Jan Nowak","Cześć, jak się masz?","2",),
    UserMyChat("Anna Kowalska","Dzisiaj jest piękny dzień","3",),
    UserMyChat("Piotr Zieliński","Czy możemy się spotkać?","4",),
    UserMyChat("Katarzyna Nowak","Mam nowy pomysł na projekt","5",),


  ];
  List<OnePerson> friendsConversationsWidget = [];
  
  String _trimText(String text) {
    if(text.length > 50) {
      return text.substring(0,50) + "...";
    }
    return text;
  }

  void _transformFriendsConversationsToWidget() {
    friendsConversationsWidget = friendsConversations.map((UserMyChat user) => OnePerson(Colors.blue, user.name, _trimText(user.lastMessage))).toList();
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


//MediaQuery.of(context).padding.top;