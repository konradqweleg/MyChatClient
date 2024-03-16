import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_code_register_form.dart';

import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account/confirm_account_request_status.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/resend_confirm_account_code_status.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';

import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
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

class RequestAcceptCode9999AsCorrect implements ConfirmAccountRequest {
  @override
  Future<Result> confirmAccount(ConfirmAccountData confirmAccountData) {
    if (confirmAccountData.code == "9999") {
      return Future.value(Result.success(ConfirmAccountRequestStatus.ok));
    } else {
      return Future.value(Result.error(ConfirmAccountRequestStatus.badCode));
    }
  }
}

class ResendAccountCodeRequestMock implements ResendConfirmAccountCodeRequest {
  @override
  Future<Result> resendActiveAccountCode(EmailData emailData) {
    return Future.value(Result.success(ResendConfirmAccountCodeStatus.ok));
  }
}



void main() {
  group('ConfirmCodeRegisterForm', () {
    testWidgets(
        'When the user enters the correct code, they should be redirected to the login page',
        (WidgetTester tester) async {
      //given
      UserRegisterData registerData = UserRegisterData("correct@mail.pl", "name", "surname", "password");

      await Utils.showView(
        tester,
        ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect(),
            ResendAccountCodeRequestMock()),
      );

      await enterConfirmCode(tester, "9999");

      //when
      await clickRegisterButton(tester);
      //then
      expect(find.byType(Login), findsOneWidget);
    });

    testWidgets(
        'Checking if the user is not logged in after entering the bad code',
        (WidgetTester tester) async {
      //given
      UserRegisterData registerData =
          UserRegisterData("correct@mail.pl", "name", "surname", "password");

      await Utils.showView(
        tester,
        ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect(),
            ResendAccountCodeRequestMock()),
      );

      await enterConfirmCode(tester, "0000");

      //when
      await clickRegisterButton(tester);
      //then
      expect(find.byType(Conversation), findsNothing);
      expect(find.text("Invalid account activation code"), findsOneWidget);
    });

    testWidgets(
        "When the registration button was clicked with a code that was ok length, the system no should display a message from validator ",
        (tester) async {

      //given
      UserRegisterData registerData = UserRegisterData("correct@mail.pl", "name", "surname", "password");

      await Utils.showView(
        tester,
        ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect(),
            ResendAccountCodeRequestMock()),
      );

      //when
      await enterConfirmCode(tester, "3455");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Not enough characters in the code"), findsNothing);
      expect(find.text("Please enter code"), findsNothing);
    });
  });

  testWidgets(
      "When the resend code is clicked, the system should display a message to the user that the code has been sent",
      (tester) async {
    //given
    UserRegisterData registerData =
        UserRegisterData("correct@mail.pl", "name", "surname", "password");

    await Utils.showView(
      tester,
      ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect(),
          ResendAccountCodeRequestMock()),
    );
    final textFinder = find.text(
        "We sent you an email with a 4-digit code. Enter it to create an account. Resend code",
        findRichText: true);

    //when
    await Utils.fireOnTapOnTextSpan(tester, textFinder, ' Resend code');

    //then
    expect(find.text('Send confirm code'), findsOneWidget);
  });
}
