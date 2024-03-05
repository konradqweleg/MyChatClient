import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_chat_client/start_app.dart';
import 'mock/di/di_utils.dart';
import 'mock/di/login/di_mock_validate_tokens_request.dart';

DiMockValidateTokensRequest diMockValidateTokensRequest =
    DiMockValidateTokensRequest();

void main() {
  group('Start App view tests', () {
    tearDown(() => DiUtils.unregisterAll());

    testWidgets('Test if first widget contains name app and logo',
        (WidgetTester tester) async {
      //given
      //when
      diMockValidateTokensRequest.registerMockDiRequestStayOnActualLoginPage();
      await tester.pumpWidget(const App());

      //then
      expect(find.text("MY CHAT"), findsOneWidget);
      expect(find.image((const AssetImage('assets/app_main_icon.png'))),
          findsOneWidget);

      //wait for change start panel to login form view
      await tester.pump(const Duration(milliseconds: 2000));
    });
  });
}
//  debugDumpRenderTree();
