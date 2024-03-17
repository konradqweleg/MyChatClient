import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/main_conversations_list/one_person/one_person_widget.dart';

import '../confirm_register_code/confirm_code_register_test.dart';
import '../mock/di/di_utils.dart';

void main() {
  setUp(() async {
    DiUtils.registerDefaultDi();
  });

  group('One person widget tests', () {
    testWidgets(
        "OnePersonWidget should display the person's name and message",
            (tester) async {
          //given
          //when

          await Utils.showView(
              tester,
              const OnePersonWidget(
                  Colors.blue, "John Doe", "Hello, how are you?"
              ));

          //then
          expect(find.text("John Doe"), findsOneWidget);
          expect(find.text("Hello, how are you?"), findsOneWidget);
        });

    testWidgets("One person widget should display the person's initials",
        (tester) async {
      //given
      //when
      await Utils.showView(
          tester,
          const OnePersonWidget(
              Colors.blue, "John Doe", "Hello, how are you?"
          ));

      //then
      expect(find.text("JD"), findsOneWidget);
    });

  });
}
