import 'package:flutter/material.dart';
import '../../../style/main_style.dart';

class MainActionButton extends StatefulWidget {
  MainActionButton({super.key, required this.text, required this.action,this.backgroundColor=MainAppStyle.mainColorApp,this.pressBackgroundColor=MainAppStyle.darkMainColorApp,this.isVisible = true});

  String text = "";
  Color backgroundColor;
  Color pressBackgroundColor;
  bool isVisible;
  void Function()? action;

  @override
  State<StatefulWidget> createState() {
    return _MainActionButtonState();
  }
}

class _MainActionButtonState extends State<MainActionButton> {
  static const double _fontSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: SizedBox(
        height: 80.0,
        child: Row(children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(

              onPressed: widget.action,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return widget.pressBackgroundColor;
                    }
                    return null;
                  },
                ),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all(widget.backgroundColor),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(MainAppStyle.defaultButtonRound),
                  ),
                ),
              ),
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: _fontSize),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
