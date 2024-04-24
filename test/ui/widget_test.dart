import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';

import 'package:my_chat_client/main.dart';
import 'mock/di/di_utils.dart';
import 'mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_bad.dart';



void main() {
  group('Start App view tests', () {
    setUp(() => DiUtils.registerDefaultDi());

    testWidgets('Test if first widget contains name app and logo',
        (WidgetTester tester) async {
      //given
      //when
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
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
