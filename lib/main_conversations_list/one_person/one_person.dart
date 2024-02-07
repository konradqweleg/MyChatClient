import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnePerson extends StatefulWidget {
  Color _personColor;
  String _personName;
  String _personMessage;

  OnePerson(this._personColor, this._personName, this._personMessage);

  @override
  State<OnePerson> createState() => _OnePersonState();
}

class _OnePersonState extends State<OnePerson> {

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;

    if (names.length < 2) {
      numWords = names.length;
    }

    for (var i = 0; i < numWords; i++) {
      if (names[i][0] != null) {
        initials += names[i][0].toUpperCase();
      }
    }

    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(widget._personName,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold )),
              Wrap( alignment: WrapAlignment.center,children: [Text(widget._personMessage,)])
            ],
          ),
        )
        ],
      )
    );

  }
}

class ColoredCircleWithText extends StatelessWidget {
  final Color color;
  final String letters;
  final double size;

  ColoredCircleWithText({required this.color, required this.letters, required this.size});

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

