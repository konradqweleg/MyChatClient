import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_mail.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';
import 'package:my_chat_client/login_and_registration/login/login_form.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_error_status.dart';

import '../helping/localizations_inject.dart';
import '../helping/utils.dart';

Future<void> enterEmail(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> enterPassword(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).last, text);
}

Future<void> clickLoginButton(WidgetTester tester) async {
  await Utils.click(tester, MainActionButton);
}

class CorrectExampleUserCredentials implements CheckCredentials {
  @override
  bool isValidCredentials(String email, String password) {
    return email == "example@mail.pl" && password == "password123";
  }
}

class MockLoginRequest implements LoginRequest {
  @override
  Future<Result> login(LoginData loginData) {
    if (loginData.email == "example@mail.pl" &&
        loginData.password == "password123") {
      return Future.value(Result.success("Tokens"));
    } else {
      return Future.value(Result.error(LoginRequestErrorStatus.badCredentials));
    }
  }

}



void main() {
  group('LoginFormTests', () {
    testWidgets(
        "When the user does not enter an email address, a message should appear asking the user to enter an email address",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      //when
      await enterEmail(tester, "");
      await clickLoginButton(tester);

      //then
      expect(find.text("Please enter an email"), findsOneWidget);
    });

    testWidgets(
        "Checking if an invalid e-mail message appears when the user enters bad format e-mail",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
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
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      //when
      await enterPassword(tester, "");
      await clickLoginButton(tester);

      //then
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    testWidgets(
        "When the user does not enter an password, a message should appear asking the user to enter an password",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      //when
      await enterPassword(tester, "");
      await clickLoginButton(tester);

      //then
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    //Update then after create main view app
    testWidgets(
        "When the user entered the correct login details he was logged into the system",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      await enterPassword(tester, "password123");
      await enterEmail(tester, "example@mail.pl");

      //when
      await clickLoginButton(tester);
      await tester.pumpAndSettle();

      //then
      expect(find.text("Logged"), findsOneWidget);
    });

    testWidgets(
        "When a user enters the wrong mail no exist in system, the system displays an error",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      await enterPassword(tester, "password123");
      await enterEmail(tester, "badmail@mail.pl");

      //when
      await clickLoginButton(tester);
      await tester.pumpAndSettle();

      //then
      expect(find.text("Incorrect login credentials"), findsOneWidget);
    });

    testWidgets(
        "When a user enters the wrong password user in system, the system displays an error",
        (tester) async {
      //given
      await Utils.showView(
          tester,
          LoginForm(
            loginRequest: MockLoginRequest(),
          ));
      await enterPassword(tester, "passwordbad");
      await enterEmail(tester, "example@mail.pl");

      //when
      await clickLoginButton(tester);
      await tester.pumpAndSettle();

      //then
      expect(find.text("Incorrect login credentials"), findsOneWidget);
    });
  });
}
