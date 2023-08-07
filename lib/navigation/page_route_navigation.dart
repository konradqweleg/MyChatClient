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


  static void _navigateTo({required Route route,required BuildContext context, bool isClearBackStack = false }){
    if(isClearBackStack){
      Navigator.pushReplacement(context, route);
    }else{
      Navigator.of(context).push(route);
    }
  }

  static void navigationTransitionSlideFromDown({required BuildContext context, required Widget destination, int delayInSeconds = 0,bool isClearBackStack = false}) {
    Future.delayed(
      Duration(seconds: delayInSeconds),
      () {
        _navigateTo(route: _createPageRouteTransitionSlideFromDown(destination), context:context,isClearBackStack: isClearBackStack);
      },
    );
  }

  static void navigation({required BuildContext context, required Widget destination,bool isClearBackStack = false}) {
    _navigateTo(route: MaterialPageRoute(builder: (context) => destination), context:context,isClearBackStack: isClearBackStack);
  }
}
