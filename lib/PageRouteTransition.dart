import 'package:flutter/material.dart';



class PageRouteTransition{
  static Route _createPageRouteTransitionSlideFromDown(Widget destinationWidget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationWidget,
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

  static void transitionAfterDelay({required BuildContext context, required Widget destination,int delayInSeconds=1}){
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).push(
          _createPageRouteTransitionSlideFromDown(destination)
      );
    });
  }
}

