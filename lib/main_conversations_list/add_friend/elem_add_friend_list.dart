import 'package:flutter/material.dart';

import '../../conversation/conversation.dart';
import '../../navigation/page_route_navigation.dart';

class ElemAddFriendList extends StatefulWidget {
  final String _personName;
  final String _personSurname;
  final int _idFriend;

  const ElemAddFriendList(this._personName, this._personSurname, this._idFriend, {super.key});

  @override
  State<ElemAddFriendList> createState() => _ElemAddFriendListState();
}

class _ElemAddFriendListState extends State<ElemAddFriendList> {

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
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top:5.0,bottom: 5.0),
          child: Row(
            children: [
              ColoredCircleWithText(
                color: Colors.blue,
                letters: getInitials("${widget._personName} ${widget._personSurname}"),
                size: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width-140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${widget._personName} ${widget._personSurname}",style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Set the button color to blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0), // Slightly round the corners
                        ),
                      ),
                      child: const Text(
                        "Add friend",
                        style: TextStyle(color: Colors.white), // Set the text color to white
                      ),
                    ),
                    // Wrap( alignment: WrapAlignment.center,children: [Text(widget._personMessage,)])
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

