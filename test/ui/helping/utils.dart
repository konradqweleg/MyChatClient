import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Utils {
  static Future<void> showView(WidgetTester tester, Widget view) async {
    await tester.pumpWidget(MaterialApp(
      title: "MY CHAT",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MainAppStyle.mainColorApp),
        useMaterial3: true,
      ),
      home: Scaffold(body: view),
    ));
    await tester.pumpAndSettle();
  }

  static Future<void> click(
      WidgetTester tester, Type typeClickedElement) async {
    await tester.tap(find.byType(typeClickedElement));
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> clickButtonFind(
      WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pump();
    await tester.pumpAndSettle();
  }



  static Future<void> enterText(
      WidgetTester tester, Finder element, String text) async {
    await tester.tap(element);
    await tester.pump();

    await tester.pump();
    await tester.enterText(element, text);
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> backOsButton(WidgetTester tester) async {
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> fireOnTapOnTextSpan(WidgetTester tester,Finder finder, String text) async {
    final Element element = finder.evaluate().single;
    final RenderParagraph paragraph = element.renderObject as RenderParagraph;

    paragraph.text.visitChildren((dynamic span) {
      if (span.text != text) return true;
      (span.recognizer as TapGestureRecognizer).onTap!();
      return false;
    });

    await tester.pump();
    await tester.pumpAndSettle();

  }
}
