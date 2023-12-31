
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';
import '../../helping/utils.dart';


Future<void> clickExitButton(WidgetTester tester) async {
  await Utils.click(tester, ExitButton);
  await tester.pump();
  await tester.pumpAndSettle();
}

Future<void> enterPassword(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> clickResetPasswordButton(WidgetTester tester) async {
  await Utils.click(tester, MainActionButton);
  await tester.pump();
  await tester.pumpAndSettle();
}


void main() {
  group('New Password test', () {

    testWidgets(
        'Checking that the ui back button takes you to the login screen.',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, NewPassword("example@mail"));
          //when
          await clickExitButton(tester);

          //then
          expect(find.byType(Login), findsOneWidget);
        });

    testWidgets(
        "Checking that the os back button takes you to the login screen.",
            (tester) async {
          //given

          //Transition from login view to registration
          await Utils.showView(tester, const Login());
          await Utils.click(tester, ResetPasswordButton);

          //Transition from login view to reset password view
          await Utils.enterText(
              tester, find.byType(TextFormField).first, "correct@mail.format");

          await Utils.clickButtonFind(tester, find.byType(MainActionButton).first);

          await Utils.enterText(tester, find.byType(TextFormField).at(1), "0000");
          await Utils.clickButtonFind(tester, find.byType(MainActionButton).last);

          //when
          await Utils.backOsButton(tester);

          //then
          expect(find.byType(Login), findsOneWidget);
        });


    testWidgets(
        'When the user does not provide a new password, the system should display a message that the password has not been entered',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, NewPassword("example@mail"));
          //when
          await enterPassword(tester,"");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Please enter your password"), findsOneWidget);
        });

    testWidgets(
        'When the user does  provide a new password, the system should display a message that the password has  been changed',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, NewPassword("example@mail"));
          //when
          await enterPassword(tester,"password");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Password has been changed"), findsOneWidget);
        });

  });
}
