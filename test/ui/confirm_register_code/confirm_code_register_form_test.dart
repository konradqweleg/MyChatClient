import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_code_register_form.dart';

import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/request/confirm_account_request_status.dart';

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
    if(confirmAccountData.code == "9999"){
      return Future.value(Result.success(ConfirmAccountRequestStatus.ok));
    }
    else{
      return Future.value(Result.error(ConfirmAccountRequestStatus.badCode));
    }
  }
}

void main() {
  group('ConfirmCodeRegisterForm', () {
    testWidgets(
        'Checking if the user is logged in after entering the correct code',
        (WidgetTester tester) async {
      //given
      UserRegisterData registerData =
          UserRegisterData("correct@mail.pl", "name", "surname", "password");

      await Utils.showView(
        tester,
        ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect()),
      );

      await enterConfirmCode(tester, "9999");

      //when
      await clickRegisterButton(tester);
      //then
      expect(find.byType(Conversation), findsOneWidget);
    });



    testWidgets(
        'Checking if the user is not logged in after entering the bad code',
            (WidgetTester tester) async {
          //given
          UserRegisterData registerData =
          UserRegisterData("correct@mail.pl", "name", "surname", "password");

          await Utils.showView(
            tester,
            ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect()),
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
              UserRegisterData registerData =
              UserRegisterData("correct@mail.pl", "name", "surname", "password");

              await Utils.showView(
                tester,
                ConfirmCodeRegisterForm(registerData, RequestAcceptCode9999AsCorrect()),
              );

          //when
          await enterConfirmCode(tester, "3455");
          await clickRegisterButton(tester);

          //then
          expect(find.text("Not enough characters in the code"), findsNothing);
          expect(find.text("Please enter code"), findsNothing);

        });
  });
}
