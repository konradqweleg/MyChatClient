import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_code.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password.dart';
import '../helping/utils.dart';

Future<void> enterEmail(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> enterCode(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).last, text);
}

Future<void> clickSendCodeButton(WidgetTester tester) async {
  await Utils.clickButtonFind(tester, find.byType(MainActionButton).first);
}

Future<void> clickResetPasswordButton(WidgetTester tester) async {
  await Utils.clickButtonFind(tester, find.byType(MainActionButton).last);
}

void main() {
  group('Reset Password', () {
    testWidgets(
        'Checking that the reset password view contains all the required elements',
            (WidgetTester tester) async {
          //given
          //when
          await Utils.showView(tester, const ResetPassword());

          //then
          expect(find.text("Send code"), findsOneWidget);
          expect(find.text("Reset password"), findsOneWidget);
          expect(find.text("Enter code"), findsOneWidget);
          expect(find.text("Enter your email"), findsOneWidget);
          expect(find.text("Enter the code\n received in the email"), findsOneWidget);
          expect(find.text("Enter the email address of the account for which you want to reset the password. "), findsOneWidget);
        });

    testWidgets(
        'Checking if the password reset button and entered code is locked initially',
            (WidgetTester tester) async {
          //given
          //when
          await Utils.showView(tester, const ResetPassword());

          //then
          expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton).last).enabled, isFalse);
          expect(tester.widget<InputCode>(find.byType(InputCode).last).isEnabled, isFalse);
        });

    testWidgets(
        'If the user does not enter the e-mail and clicks the send code button, the system should display information for the user to enter the e-mail.',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, const ResetPassword());

          //when
          await clickSendCodeButton(tester);

          //then
          expect(find.text("Please enter an email"),findsOneWidget);
        });

    testWidgets(
        'If the user enters the email in the wrong format and clicks on the send code button, the system should display an error message to the user',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, const ResetPassword());
          await enterEmail(tester, "badmailformat");
          //when
          await clickSendCodeButton(tester);

          //then
          expect(find.text("The email address is in an invalid format"),findsOneWidget);
        });


  });
}
