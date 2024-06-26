import 'package:flutter/material.dart';
import 'package:my_chat_client/conversation/conversation.dart';

import '../../navigation/page_route_navigation.dart';

class OnePersonWidget extends StatefulWidget {
  final Color _personColor;
  final String _personName;
  final String _personMessage;
  final int _idFriend;

  const OnePersonWidget(this._personColor, this._personName, this._personMessage, this._idFriend, {super.key});

  @override
  State<OnePersonWidget> createState() => _OnePersonWidgetState();
}

class _OnePersonWidgetState extends State<OnePersonWidget> {

  String getInitials(String name) {
    int maxInitialsCharacters = 2;
    List<String> names = name.split(" ");
    String initials = "";

    if (names.length < maxInitialsCharacters) {
      maxInitialsCharacters = names.length;
    }

    for (var i = 0; i < maxInitialsCharacters; i++) {
      initials += names[i][0].toUpperCase();
    }

    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageRouteNavigation.navigation(
            context: context,
            destination: Conversation(idFriend: widget._idFriend),
            isClearBackStack: false);
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Row(
            children: [
              ColoredCircleWithText(
                color: widget._personColor,
                letters: getInitials(widget._personName),
                size: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width-120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget._personName,style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                    Wrap( alignment: WrapAlignment.center,children: [Text(widget._personMessage,)])
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}

class ColoredCircleWithText extends StatelessWidget {
  final Color color;
  final String letters;
  final double size;

  const ColoredCircleWithText({super.key, required this.color, required this.letters, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          letters,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

