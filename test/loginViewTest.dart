import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';

import 'helping/localizations_inject.dart';

void main() {
  group('Login', () {
    testWidgets(
        'Checking that the login view contains all the required elements',
        (WidgetTester tester) async {
      //given
      //when
      await tester.pumpWidget(const LocalizationsInject(child: Login()));

      //then
      expect(find.text("Enter your email"), findsOneWidget);
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);

      expect(find.text("CREATE NEW \n ACCOUNT"), findsOneWidget);
      expect(find.text("I FORGOT MY PASSWORD"), findsOneWidget);
      expect(find.text("GOOGLE"), findsOneWidget);
      expect(find.text("FACEBOOK"), findsOneWidget);
    });


    testWidgets("Check if back button close app when user is on Login view", (widgetTester) async{
      //given
      await widgetTester.pumpWidget(const LocalizationsInject(child: Login()));
      final NavigatorState navigator = widgetTester.state(find.byType(Navigator));

      //when
      navigator.pop();
      await widgetTester.pump();

      //then
      expect(exitCode, 0);

    });
    
    
    testWidgets("Check is show error when email is too short", (tester)  async {
      await tester.pumpWidget(const LocalizationsInject(child: Login()));
      await tester.pumpAndSettle();
     // debugDumpRenderTree();
      await tester.tap(find.byType(InputEmail));
      await tester.pump();
      await tester.pump(Duration(milliseconds:400));

    //  expect(find.byElementType(InputEmail), findsOneWidget);
      await tester.pump();
      await tester.enterText(find.byType(TextFormField).first, "email");
      await tester.pump();

      await tester.pumpAndSettle();
      await tester.tap(find.byType(MainActionButton));
      await tester.pump();
      expect(find.text("The email address is in an invalid format"),findsOneWidget);


    });




  })























  ;
}
