import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/start_app.dart';


void main() {

  testWidgets('Verify that the applications start screen contains the applications logo and name', (WidgetTester tester) async {

    //given
    //when
    await tester.pumpWidget(const App());

    //then
    expect(find.text("MY CHAT"), findsOneWidget);
    expect(find.image((const AssetImage('assets/app_main_icon.png'))), findsOneWidget);

    //wait for change start panel to login form view
    await tester.pump(const Duration(seconds: 2));

  });


}
