import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import 'package:my_chat_client/main.dart';

import 'mock/di/di_utils.dart';
import 'mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_bad.dart';


void main() {


  group('Start App tests', () {

  setUp(() => DiUtils.registerDefaultDi());

  testWidgets('Verify that the applications start screen contains the applications logo and name', (WidgetTester tester) async {

    //given
    DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());

    //when
    await tester.pumpWidget(const App());

    //then
    expect(find.text("MY CHAT"), findsOneWidget);
    expect(find.image((const AssetImage('assets/app_main_icon.png'))), findsOneWidget);

    //wait for change start panel to login form view
    await tester.pump(const Duration(seconds: 2));

  });

  });





}
