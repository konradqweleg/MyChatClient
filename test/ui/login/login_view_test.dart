import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/database/create_db/db_create_service.dart';
import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import 'package:my_chat_client/login_and_registration/register/register.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';
import '../helping/utils.dart';
import '../mock/di/di_utils.dart';
import '../mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_bad.dart';
import '../mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_correct.dart';

Future<void> clickCreateNewAccountButton(WidgetTester tester) async {
  await Utils.click(tester, CreateNewAccountButton);
}

Future<void> clickResetPassword(WidgetTester tester) async {
  await Utils.click(tester, ResetPasswordButton);
}



void main() {
  group('Login', () {
    setUp(() async {
      DiUtils.registerDefaultDi();
    }
    );


    testWidgets(
        'The application should remain on the login view when request return redirect to login page.',
            (WidgetTester tester) async {

          //given
          DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());

          //when
          await Utils.showView(tester, Login());

          //then
          expect(find.byType(Login), findsOneWidget);

        });

    testWidgets(
        'The application should remain on the login view when tokens are rejected.',
        (WidgetTester tester) async {
      //given
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());

      //when
      await Utils.showView(tester, Login());

      //then
      expect(find.byType(Login), findsOneWidget);
    });



    testWidgets(
        'Checking that the login view contains all the required elements',
        (WidgetTester tester) async {
      //given
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());


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
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
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
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
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
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
      await Utils.showView(tester, Login());

      //when
      await clickResetPassword(tester);

      //then
      expect(find.byType(ResetPassword), findsOneWidget);
    });
  });
}
