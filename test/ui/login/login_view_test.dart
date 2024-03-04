import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/register/register.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';
import '../helping/utils.dart';
import '../mock/di/di_utils.dart';
import '../mock/di/login/di_mock_validate_tokens_request.dart';

Future<void> clickCreateNewAccountButton(WidgetTester tester) async {
  await Utils.click(tester, CreateNewAccountButton);
}

Future<void> clickResetPassword(WidgetTester tester) async {
  await Utils.click(tester, ResetPasswordButton);
}

DiMockValidateTokensRequest diMockValidateTokensRequest =
    DiMockValidateTokensRequest();

void main() {
  group('Login', () {
    tearDown(() async {
      await DiUtils.unregisterAll();
    });

    testWidgets(
        'The application should remain on the login view when tokens are rejected.',
        (WidgetTester tester) async {
      //given
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();

      //when
      await Utils.showView(tester, Login());

      //then
      expect(find.byType(Login), findsOneWidget);
    });

    testWidgets(
        'The application should transition from the login view to the main conversation view when it has valid tokens stored or when their state cannot be determined.',
        (WidgetTester tester) async {
      //given
      diMockValidateTokensRequest
          .registerMockDiRequestGoToMainConversationPage();

      //when
      await Utils.showView(tester, Login());

      //then
      expect(find.byType(MainConversationList), findsOneWidget);
    });

    testWidgets(
        'Checking that the login view contains all the required elements',
        (WidgetTester tester) async {
      //given
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();

      //when
      await Utils.showView(tester, Login());

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
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();
      await Utils.showView(tester, Login());

      //when
      await Utils.backOsButton(tester);

      //then
      expect(exitCode, 0);
    });

    testWidgets(
        "Account creation button takes you to the account creation view",
        (tester) async {
      //given
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();
      await Utils.showView(tester, Login());

      //when
      await clickCreateNewAccountButton(tester);

      //then
      expect(find.byType(Register), findsOneWidget);
    });

    testWidgets(
        "Account forgot password button takes you to the reset password view",
        (tester) async {
      //given
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();
      await Utils.showView(tester, Login());

      //when
      await clickResetPassword(tester);

      //then
      expect(find.byType(ResetPassword), findsOneWidget);
    });
  });
}
