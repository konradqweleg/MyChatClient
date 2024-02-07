

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/user_my_chat.dart';

import '../one_person/one_person.dart';

class ListConversations extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return ListConversationsState();
  }
}

class ListConversationsState extends State<ListConversations> {

  List<UserMyChat> friendsConversations = [
    UserMyChat("Konrad Groń","Ostatnio w twojej sprawie nie było dobrze","1",Colors.blue),
    UserMyChat("Damian Golonka","Ale to nie jest tak że ten PVM nie chce działać to po prostu kod jest zły","1",Colors.green),
    UserMyChat("Mateusz Rysula","Wiesz on mi ostatnio powiedział że to bez sensu","1",Colors.orange),
    UserMyChat("Andrzej Sroka","Przegraliśmy","1",Colors.red),
    UserMyChat("Kamil Kowalski","Wiesz on mi ostatnio powiedział że to bez sensu","1",Colors.amber),
    UserMyChat("Jakub Kowalski","Ani nie dobrze ani źle","1",Colors.blue),
    UserMyChat("Sebastian Pawlak","Polska wygrała","1",Colors.purple),
    UserMyChat("Sebastian Pawlak","Polska wygrała","1",Colors.purple),
    UserMyChat("Jan Nowak","Cześć, jak się masz?","2",Colors.green),
    UserMyChat("Anna Kowalska","Dzisiaj jest piękny dzień","3",Colors.red),
    UserMyChat("Piotr Zieliński","Czy możemy się spotkać?","4",Colors.yellow),
    UserMyChat("Katarzyna Nowak","Mam nowy pomysł na projekt","5",Colors.orange),


  ];
  List<OnePerson> friendsConversationsWidget = [];

  void _transformFriendsConversationsToWidget() {
    friendsConversationsWidget = friendsConversations.map((UserMyChat user) => OnePerson(user.color, user.name, user.lastMessage)).toList();
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