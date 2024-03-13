import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/database/create_db/db_create_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';

import 'package:my_chat_client/login_and_registration/login/check_credentials.dart';
import 'package:my_chat_client/login_and_registration/login/login_form.dart';

import 'package:my_chat_client/login_and_registration/login/request/login_request.dart';
import 'package:my_chat_client/login_and_registration/login/request/login_request_error_status.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_data/login_data.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/tokens_data.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/list_conversations.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';
import 'package:my_chat_client/main_conversations_list/requests/request_last_message.dart';

import '../helping/db_utils.dart';
import '../helping/utils.dart';
import '../mock/di/di_utils.dart';
import 'mock/mock_download_last_messages_with_friends.dart';
import 'mock/mock_info_about_me_service.dart';


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
      return Future.value(Result.success(TokensData(
          accessToken: 'accessToken', refreshToken: 'requestToken')));
    } else {
      return Future.value(Result.error(LoginRequestErrorStatus.badCredentials));
    }
  }
}

void main() {
  setUp(() async {
    DiUtils.registerDefaultDi();
  });

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

    testWidgets(
        "When the user entered the correct login details he was logged into the system",
        (tester) async {
      //given

      DbUtils dbUtils = DbUtils();
      await dbUtils.cleanAllDataInDatabase();

      DiUtils.get().registerSingleton<InfoAboutMeService>(MockInfoAboutMeService());
      DiUtils.get().registerSingleton<RequestLastMessage>(MockDownloadLastMessagesWithFriends());

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
      expect(find.byType(MainConversationList), findsOneWidget);
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
