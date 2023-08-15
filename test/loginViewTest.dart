

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';

import 'helping/localizations_inject.dart';

void main() {
  group('Login', () {
    testWidgets(
        'Checking that the login view contains all the required elements', (
        WidgetTester tester) async {
      //given
      //when
      await tester.pumpWidget(const LocalizationsInject(child: Login()));

      //then
      expect(find.text("Enter your email"), findsOneWidget);
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);

      // expect(find.("CREATE NEW\n ACCOUNT"), findsOneWidget);
      expect(find.text("I FORGOT MY PASSWORD"), findsOneWidget);
      expect(find.text("GOOGLE"), findsOneWidget);
      expect(find.text("FACEBOOK"), findsOneWidget);


      // expect(find.byWidgetPredicate((widget) {
      // RegExp createNewAccountPatternButtonText = RegExp("CREATE*NEW*ACCOUNT");
      // if (widget is Text) {
      // final Text textWidget = widget as Text;
      //
      //   if (textWidget.data != null){
      //     String? text__=textWidget.data;
      //     return  createNewAccountPatternButtonText.hasMatch(text__!);
      //   }
      // }
      //
      // if(widget is TextSpan){
      //   TextSpan xx = widget as TextSpan;
      //   return  createNewAccountPatternButtonText.hasMatch(xx.text!);
      // }
      //
      //   return false;
      // })
      // ,
      // findsOneWidget
      // );
    });
  });
}
