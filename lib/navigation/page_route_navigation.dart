import 'package:flutter/material.dart';

class PageRouteNavigation {
  static Route _createPageRouteTransitionSlideFromDown(
      Widget destinationWidget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Scaffold(body: destinationWidget),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  static void navigationTransitionSlideFromDown({required BuildContext context, required Widget destination, int delayInSeconds = 0}) {
    Future.delayed(
      Duration(seconds: delayInSeconds),
      () {
        Navigator.of(context).push(
          _createPageRouteTransitionSlideFromDown(destination),
        );
      },
    );
  }

  static void navigation({required BuildContext context, required Widget destination}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
