import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/resend_active_account_code/email_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/send_reset_password_code/request_reset_password_code_status.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/send_reset_password_code/send_reset_password_code_request.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/Is_correct_password_code_request_status.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/email_and_code_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/request/validate_reset_password_code/is_correct_reset_password_code.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password_form.dart';
import '../helping/utils.dart';

Future<void> enterEmail(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> enterCode(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).last, text);
}

Future<void> clickSendCodeButton(WidgetTester tester) async {
  await Utils.clickButtonFind(tester, find.byType(MainActionButton).first);
}

Future<void> clickResetPasswordButton(WidgetTester tester) async {
  await Utils.clickButtonFind(tester, find.byType(MainActionButton).last);
}


class MockIsCorrectResetPasswordCodeAcceptAllData implements IsCorrectResetPasswordCode{

  @override
  Future<Result> isCorrectResetPasswordCode(EmailAndCodeData emailAndCodeData) {
      return Future.value(Result.success(true));

  }

}

class MockIsCorrectResetPasswordCodeBadCode implements IsCorrectResetPasswordCode{

  @override
  Future<Result> isCorrectResetPasswordCode(EmailAndCodeData emailAndCodeData) {
    return Future.value(Result.error(IsCorrectPasswordCodeRequestStatus.badCode));

  }

}


class MockSendResetPasswordCodeEachUserNotExists implements SendResetPasswordCodeRequest{

  @override
  Future<Result> sendResetPasswordCode(EmailData email) {
      return Future.value(Result.error(RequestResetPasswordCodeStatus.userNotExist));
  }
}

class MockSendResetPasswordCodeAcceptAllData implements SendResetPasswordCodeRequest{

  @override
  Future<Result> sendResetPasswordCode(EmailData email) {
    return Future.value(Result.success(true));
  }
}


void main() {
  group('Reset Password Form Test', () {



    testWidgets(
        'If the user has entered the correct email format but the user does not exist in the database, the system should display information to the user',
            (WidgetTester tester) async {
          //given

          await Utils.showView(tester,ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeEachUserNotExists()));
          //when
          await enterEmail(tester, "no@existemail.pl");
          await clickSendCodeButton(tester);

          await tester.pumpAndSettle();
          await tester.pumpAndSettle();
          //then
          expect(find.text("The user with the provided email address does not exist."), findsOneWidget);
        });

    testWidgets(
        'If the user has entered the correct email  and  the user does exist in the database, the system should send code on mail',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          //when
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //then
          expect(find.text("A password reset code has been sent"), findsOneWidget);
        });

    testWidgets(
        'If the user has entered the correct email  and  the user does exist in the database, the system should show resend code text and disable send code button',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          //when
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //then
          expect(find.text("Enter the email address of the account for which you want to reset the password. Resend code" ,findRichText: true), findsOneWidget);
          expect(tester.widget<MainActionButton>(find.byType(MainActionButton).first).action, isNull);
        });

    testWidgets(
        'After clicking resend code, the message should be sent again',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);
          //when
          final textWithFragmentResendCode = find.text(
              "Enter the email address of the account for which you want to reset the password. Resend code",
              findRichText: true);

          //when
          final gesture = await tester.startGesture(tester.getCenter(textWithFragmentResendCode));
          await gesture.up();
          await tester.pump();

          //then
          expect(find.text("A password reset code has been sent" ,findRichText: true), findsOneWidget);
        });

    testWidgets(
        'When the user no enters the code, the system should display message please enter code',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //when
          await enterCode(tester, "");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Please enter code"), findsOneWidget);
        });

    testWidgets(
        'When the user enters a code that is too short, the system should display an error message',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //when
          await enterCode(tester, "55");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Not enough characters in the code"), findsOneWidget);
        });

    testWidgets(
        'When the user enters the wrong code, the system should display an error message',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeBadCode(),MockSendResetPasswordCodeAcceptAllData()));
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //when
          await enterCode(tester, "6666");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Invalid code entered"), findsOneWidget);
        });

    testWidgets(
        'Once the user enters the correct code, the system should go to the password change screen',
            (WidgetTester tester) async {
          //given
          await Utils.showView(tester,  ResetPasswordForm(MockIsCorrectResetPasswordCodeAcceptAllData(),MockSendResetPasswordCodeAcceptAllData()));
          await enterEmail(tester, "test@mail.eu");
          await clickSendCodeButton(tester);

          //when
          await enterCode(tester, "0000");
          await clickResetPasswordButton(tester);
          //then
          expect(find.byType(NewPassword), findsOneWidget);
        });




  });
}
