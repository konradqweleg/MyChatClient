import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/register/register.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password.dart';

import '../helping/utils.dart';



Future<void> clickCreateNewAccountButton(WidgetTester tester) async{
 await Utils.click(tester, CreateNewAccountButton);
}

Future<void> clickResetPassword(WidgetTester tester) async{
  await Utils.click(tester, ResetPasswordButton);
}

void main() {
  group('Login', () {
    testWidgets(
        'Checking that the login view contains all the required elements',
        (WidgetTester tester) async {
      //given
      //when
      await Utils.showView(tester, const Login());

      //then
      expect(find.text("Enter your email"), findsOneWidget);
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("CREATE NEW \n ACCOUNT"), findsOneWidget);
      expect(find.text("I FORGOT MY PASSWORD"), findsOneWidget);
      expect(find.text("GOOGLE"), findsOneWidget);
      expect(find.text("FACEBOOK"), findsOneWidget);
    });

    testWidgets(
        "Checking if the back button closes applications on the login screen",
        (tester) async {
      //given
      await Utils.showView(tester, const Login());

      //when
      await Utils.backOsButton(tester);

      //then
      expect(exitCode, 0);
    });

    testWidgets(
        "Account creation button takes you to the account creation view",
        (tester) async {
      //given
      await Utils.showView(tester, const Login());

      //when
      await clickCreateNewAccountButton(tester);

      //then
      expect(find.byType(Register), findsOneWidget);
    });

    testWidgets(
        "Account forgot password button takes you to the reset password view",
        (tester) async {
      //given
      await Utils.showView(tester, const Login());

      //when
      await clickResetPassword(tester);

      //then
      expect(find.byType(ResetPassword), findsOneWidget);
    });
  });
}
