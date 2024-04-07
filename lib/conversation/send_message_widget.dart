import 'package:flutter/material.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({Key? key}) : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: AppLocalizations.of(context)!.writeMessage,
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Visibility(
              visible: _hasText,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainAppStyle.mainColorApp,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),

                  child: Text(AppLocalizations.of(context)!.sendMessage, style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}