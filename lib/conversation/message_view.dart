import 'package:flutter/material.dart';
import 'package:my_chat_client/style/main_style.dart';

class MessageView extends StatelessWidget{

  bool isMessageFromFromFriend;
  String message;
  final Color _friendMessageColor = const Color(0xFFE9EEF5);
  MessageView({super.key, required this.isMessageFromFromFriend, required this.message});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.80,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isMessageFromFromFriend ?  _friendMessageColor : MainAppStyle.mainColorApp,
          borderRadius: BorderRadius.only(
            topLeft:  const Radius.circular(6.0),
            topRight: const Radius.circular(6.0),
            bottomRight: isMessageFromFromFriend ?  const Radius.circular(6.0) : Radius.zero,
            bottomLeft: isMessageFromFromFriend ? Radius.zero : const Radius.circular(6.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(message, style: TextStyle(color: isMessageFromFromFriend ? Colors.black : Colors.white)),
        ),
      ),
    );
  }
}