
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/conversation/conversation.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_code_register_form.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/create_account_data.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/validate_confirm_code.dart';

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

class ValidatorConfirmCode9999 implements ValidateConfirmCode{
  @override
  bool isValidConfirmCode(CreateAccountData createAccountData) {
       return createAccountData.confirmCode == "9999";
  }

}

void main() {
  group('ConfirmCodeRegisterForm', () {
    testWidgets(
        'Checking that the confirm create account view contains all the required elements',
            (WidgetTester tester) async {
          //given
          //when
          UserRegisterData registerData =
          UserRegisterData("correct@mail.pl", "name", "surname", "password");
          await Utils.showView(tester,

              ConfirmCodeRegisterForm(registerData,ValidatorConfirmCode9999())
          );

       //   await enterConfirmCode(tester, "9999");
       //   tester.pumpAndSettle();
         // await clickRegisterButton(tester);

          expect(find.byType(Conversation), findsOneWidget);

        });

  });
}
