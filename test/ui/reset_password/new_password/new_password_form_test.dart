
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/new_password_form.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/change_password_data.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password.dart';
import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/request_change_password_status.dart';
import '../../helping/utils.dart';
import '../../mock/di/di_utils.dart';
import '../../mock/di/login/di_mock_validate_tokens_request.dart';


Future<void> enterPassword(WidgetTester tester, String text) async {
  await Utils.enterText(tester, find.byType(TextFormField).first, text);
}

Future<void> clickResetPasswordButton(WidgetTester tester) async {
  await Utils.click(tester, MainActionButton);
  await tester.pump();
  await tester.pumpAndSettle();
}

class RequestChangePasswordMock implements RequestChangePassword{
  @override
  Future<Result> requestChangePassword(ChangePasswordData changePasswordData) async {
    return Result.success( RequestChangePasswordStatus.ok);
  }
}

DiMockValidateTokensRequest diMockValidateTokensRequest =
DiMockValidateTokensRequest();

void main() {
  group('New Password test', () {

    tearDown(() async => await DiUtils.unregisterAll());

    testWidgets(
        'When the user does  provide a new password, the system should display a message that the password has  been changed',
            (WidgetTester tester) async {
          //given
          diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();
          await Utils.showView(tester,  NewPasswordForm("correct@mail.eu", "9999",RequestChangePasswordMock()));
          //when
          await enterPassword(tester,"password");
          await clickResetPasswordButton(tester);
          //then
          expect(find.text("Password has been changed"), findsOneWidget);
        });

  });
}
