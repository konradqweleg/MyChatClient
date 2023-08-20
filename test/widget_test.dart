// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/start_app.dart';
import 'package:my_chat_client/test_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });


  testWidgets('Test if first widget contains name app and logo', (WidgetTester tester) async {

    //given
    //when
    await tester.pumpWidget(const App());

    //then
    expect(find.text("MY CHAT"), findsOneWidget);
    expect(find.image((const AssetImage('assets/app_main_icon.png'))), findsOneWidget);


    //wait for change start panel to login form view
    await tester.pump(const Duration(milliseconds: 2000));

  });



}
