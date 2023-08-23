import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import '../helping/utils.dart';


Future<void> clickExitButton(WidgetTester tester) async {
  await Utils.click(tester, ExitButton);
  await tester.pump();
  await tester.pumpAndSettle();
}

Future<void> enterConfirmCode(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> clickRegisterButton(WidgetTester tester) async {
  await Utils.click(tester, MainActionButton);
  await tester.pump();
  await tester.pumpAndSettle();
}

void main() {
  group('ConfirmCodeRegister', () {
    testWidgets(
        'Checking that the confirm create account view contains all the required elements',
            (WidgetTester tester) async {
          //given
          //when
          await Utils.showView(tester, const ConfirmRegisterCode());

          //then
          expect(find.text("Enter code"), findsOneWidget);
          expect(find.text("We sent you an email with a 4-digit code. Enter it to create an account.Resend code", findRichText: true), findsOneWidget);
          expect(find.text("Register"), findsOneWidget);
          expect(find.byType(ExitButton), findsOneWidget);

        });

    testWidgets(
        'Checking that the ui back button takes you to the login screen.',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester, const ConfirmRegisterCode());
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
          await Utils.click(tester, CreateNewAccountButton);


          //Transition from register view to confirm code register
          await Utils.enterText(tester, find.byType(TextFormField).first, "correct@mail.format");
          await Utils.enterText(tester, find.byType(TextFormField).at(1), "name");
          await Utils.enterText(tester, find.byType(TextFormField).at(2), "surname");
          await Utils.enterText(tester, find.byType(TextFormField).at(3), "password");
          await Utils.click(tester, MainActionButton);

          //when
          await Utils.backOsButton(tester);

          //then
          expect(find.byType(Login), findsOneWidget);
        });

    testWidgets(
        "When the resend code is clicked, the system should display a message to the user that the code has been sent",
            (tester) async {
          //given
          await Utils.showView(tester, const ConfirmRegisterCode());
          final textFinder = find.text("We sent you an email with a 4-digit code. Enter it to create an account.Resend code", findRichText: true);

          //when
          final gesture = await tester.startGesture(tester.getCenter(textFinder));
          await gesture.up();
          await tester.pump();

          //then
          expect(find.text("Send confirm code"), findsOneWidget);
        });

    testWidgets(
        "When you clicked the registration button without entering the code, the system should display a message asking you to enter the code",
            (tester) async {
          //given
          await Utils.showView(tester, const ConfirmRegisterCode());

          //when
          await enterConfirmCode(tester, "");
          await clickRegisterButton(tester);

          //then
          expect(find.text("Please enter code"), findsOneWidget);
          expect(find.byType(ConfirmRegisterCode), findsOneWidget);
        });

    testWidgets(
        "When the registration button was clicked with a code that was too short, the system should display a message stating that the code was given too short",
            (tester) async {
          //given
          await Utils.showView(tester, const ConfirmRegisterCode());

          //when
          await enterConfirmCode(tester, "34");
          await clickRegisterButton(tester);

          //then
          expect(find.text("Not enough characters in the code"), findsOneWidget);
          expect(find.byType(ConfirmRegisterCode), findsOneWidget);
        });

    testWidgets(
        "When the registration button was clicked with a code that was ok length, the system no should display a message from validator ",
            (tester) async {
          //given
          await Utils.showView(tester, const ConfirmRegisterCode());

          //when
          await enterConfirmCode(tester, "3455");
          await clickRegisterButton(tester);

          //then
          expect(find.text("Not enough characters in the code"), findsNothing);
          expect(find.text("Please enter code"), findsNothing);
          expect(find.byType(ConfirmRegisterCode), findsOneWidget);
        });

  });
}
