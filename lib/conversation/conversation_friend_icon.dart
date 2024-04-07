import 'package:flutter/material.dart';

import '../style/main_style.dart';

class ConversationFriendIcon extends StatefulWidget {
  final String _personName;

  const ConversationFriendIcon(this._personName, {super.key});

  @override
  State<ConversationFriendIcon> createState() => _ConversationFriendIconState();
}

class _ConversationFriendIconState extends State<ConversationFriendIcon> {

  String getInitials(String name) {


    int maxInitialsCharacters = name.split(" ").length;
    List<String> names = name.split(" ");
    String initials = "";

    if (name.isEmpty) {
      maxInitialsCharacters = 0;
    }

    for (var i = 0; i < maxInitialsCharacters; i++) {
      initials += names[i][0].toUpperCase();
    }

    return initials;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Center( // Wrap the Column with a Center widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10), // Space between arrow and circle
            ColoredCircleWithText(
              letters: getInitials(widget._personName),
              size: 50,
            ),
            const SizedBox(height: 10), // Space between circle and name
            Text(
              widget._personName,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white),
              textAlign: TextAlign.center, // Center the text
            ),
          ],
        ),
      ),
    );


  }
}



class ColoredCircleWithText extends StatelessWidget {
  final String letters;
  final double size;


  const ColoredCircleWithText({super.key, required this.letters, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          letters,
          style: TextStyle(
            color:  MainAppStyle.mainColorApp,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

