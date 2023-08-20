import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/login/login_form.dart';

import 'helping/localizations_inject.dart';
// debugDumpRenderTree();

Future<void> enterEmail(WidgetTester tester, String text) async {
  await tester.tap(find.byType(InputEmail));
  await tester.pump();

  await tester.pump();
  await tester.enterText(find.byType(TextFormField).first, text);
  await tester.pump();
  await tester.pumpAndSettle();
}

Future<void> enterPassword(WidgetTester tester, String text) async {
  await tester.tap(find.byType(InputPassword));
  await tester.pump();

  await tester.pump();
  await tester.enterText(find.byType(TextFormField).last, text);
  await tester.pump();
  await tester.pumpAndSettle();
}

// Future<void> showLoginView(WidgetTester tester) async {
//   await tester.pumpWidget(const LocalizationsInject(child: Login()));
//   await tester.pumpAndSettle();
// }

Future<void> showLoginFormView(WidgetTester tester) async {
  await tester.pumpWidget(LocalizationsInject(
      child: LoginForm(checkCredentials: CorrectExampleUserCredentials())));
  await tester.pumpAndSettle();
}

Future<void> clickLoginButton(WidgetTester tester) async {
  await tester.tap(find.byType(MainActionButton));
  await tester.pump();
}

class CorrectExampleUserCredentials implements CheckCredentials {
  @override
  bool isValidCredentials(String email, String password) {
    return email == "example@mail.pl" && password == "password123";
  }
}

void main() {
  group('LoginFormTests', () {




    testWidgets(
        "When the user does not enter an email address, a message should appear asking the user to enter an email address",
            (tester) async {
          //given
          await showLoginFormView(tester);
          //when
          await enterEmail(tester, "");
          await tester.tap(find.byType(MainActionButton));
          await tester.pump();

          //then
          expect(find.text("Please enter an email"), findsOneWidget);
        });

    testWidgets(
        "Checking if an invalid e-mail message appears when the user enters bad format e-mail",
            (tester) async {
          //given
          await showLoginFormView(tester);
          //when
          await enterEmail(tester, "email.bad.format");
          await clickLoginButton(tester);

          //then
          expect(find.text("The email address is in an invalid format"),
              findsOneWidget);
        });

    testWidgets(
        "When the user does not enter an password, a message should appear asking the user to enter an password",
            (tester) async {
          //given
          await showLoginFormView(tester);
          //when
          await enterPassword(tester, "");
          await tester.tap(find.byType(MainActionButton));
          await tester.pump();

          //then
          expect(find.text("Please enter your password"), findsOneWidget);
        });

    testWidgets(
        "When the user does not enter an password, a message should appear asking the user to enter an password",
            (tester) async {
          //given
          await showLoginFormView(tester);
          //when
          await enterPassword(tester, "");
          await tester.tap(find.byType(MainActionButton));
          await tester.pump();

          //then
          expect(find.text("Please enter your password"), findsOneWidget);
        });
  });
}
