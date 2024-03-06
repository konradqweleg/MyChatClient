import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/undo_button.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import 'package:my_chat_client/login_and_registration/register/register.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import '../helping/utils.dart';
import '../mock/di/di_utils.dart';
import '../mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_bad.dart';


Future<void> enterTextEmail(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> enterUsername(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).at(1), text);
}

Future<void> enterSurname(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).at(2), text);
}

Future<void> enterPassword(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).at(3), text);
}

Future<void> clickRegisterButton(WidgetTester tester) async {
  await Utils.click(tester, MainActionButton);
}

class MockRegisterUserRequestRegisterAllRequests extends RegisterUserRequest {
  @override
  Future<Result> register(UserRegisterData userRegisterData) {
    return Future.value(Result.success(RegisterResponseStatus.ok));
  }
}


void main() {
  group('Register', () {

    setUp(() => DiUtils.registerDefaultDi());

    testWidgets(
        'Checking that the register view contains all the required elements',
        (WidgetTester tester) async {
      //given
      //when
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //then
      expect(find.text("Enter your email"), findsOneWidget);
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.text("Username"), findsOneWidget);
      expect(find.text("Surname"), findsOneWidget);
      expect(find.text("Register"), findsOneWidget);
    });

    testWidgets(
        'If the user has not entered an email address, the system should display information to the user to enter an email.',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter an email"), findsOneWidget);
    });

    testWidgets(
        'If the user has entered an incorrect email address format the system should display information to the user about the incorrect email format.',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "bad.mail.format");
      await clickRegisterButton(tester);

      //then
      expect(find.text("The email address is in an invalid format"),
          findsOneWidget);
    });

    testWidgets(
        'If the user has entered the correct email format the system does not display an error',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "correct@mail.format");
      await clickRegisterButton(tester);

      //then
      expect(
          find.text("The email address is in an invalid format"), findsNothing);
      expect(find.text("Please enter an email"), findsNothing);
    });

    testWidgets(
        'If the user has entered the correct email format the system does not display an error',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "correct@mail.format");
      await clickRegisterButton(tester);

      //then
      expect(
          find.text("The email address is in an invalid format"), findsNothing);
      expect(find.text("Please enter an email"), findsNothing);
    });

    testWidgets(
        'If the users name has not been entered, the system should display a message asking for input',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterUsername(tester, "");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter data"), findsAtLeastNWidgets(2));
    });

    testWidgets(
        'If the user has entered a surname the system should not display a name validation error',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterSurname(tester, "surname");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter data"), findsOneWidget);
    });

    testWidgets(
        'If the users surname has not been entered, the system should display a message asking for input',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterSurname(tester, "");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter data"), findsAtLeastNWidgets(2));
    });

    testWidgets(
        'If the user has entered a password the system should not display a name validation error',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterPassword(tester, "password");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter your password"), findsNothing);
    });

    testWidgets(
        'If the users password has not been entered, the system should display a message asking for input password',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterPassword(tester, "");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter your password"), findsOneWidget);
    });

    testWidgets(
        'If there are errors in the form, the system should not change the view when the registration button is pressed',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "wrong.mail.format");
      await enterUsername(tester, "name");
      await enterSurname(tester, "surname");
      await enterPassword(tester, "password");
      await clickRegisterButton(tester);

      //then
      expect(find.byType(Register), findsOneWidget);
    });

    testWidgets(
        'If there are no errors in the form, the system should show the user the screen for entering the account creation confirmation code',
        (WidgetTester tester) async {
      //given
      await Utils.showView(
          tester, Register(MockRegisterUserRequestRegisterAllRequests()));

      //when
      await enterTextEmail(tester, "correct@mail.format");
      await enterUsername(tester, "name");
      await enterSurname(tester, "surname");
      await enterPassword(tester, "password");
      await clickRegisterButton(tester);

      //then
      expect(find.byType(ConfirmRegisterCode), findsOneWidget);
    });

    testWidgets(
        'In the registration view, the os back button should go back to the login view',
        (WidgetTester tester) async {
      //given
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
      await Utils.showView(tester, Login());
      await Utils.click(tester, CreateNewAccountButton);

      //when
      await Utils.backOsButton(tester);

      //then
      expect(find.byType(Login), findsOneWidget);
    });

    testWidgets(
        'In the registration view, the back arrow button should go back to the login view',
        (WidgetTester tester) async {
      //given
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
      await Utils.showView(tester, Login());
      await Utils.click(tester, CreateNewAccountButton);

      //when
      await Utils.click(tester, UndoButton);

      //then
      expect(find.byType(Login), findsOneWidget);
    });
  });
}
