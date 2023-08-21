import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'localizations_inject.dart';

class Utils {
  static Future<void> showView(WidgetTester tester, Widget view) async {
    await tester.pumpWidget(LocalizationsInject(
      child: view,
    ));
    await tester.pumpAndSettle();
  }


  static Future<void> click(WidgetTester tester,Type typeClickedElement) async{
    await tester.tap(find.byType(typeClickedElement));
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> enterText(WidgetTester tester,Finder element,String text) async{
    await tester.tap(element);
    await tester.pump();

    await tester.pump();
    await tester.enterText(element, text);
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> backOsButton(WidgetTester tester) async{
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pump();
    await tester.pumpAndSettle();
  }



}
