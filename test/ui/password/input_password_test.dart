import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/input/input_password.dart';
import '../helping/utils.dart';

Future<void> clickLockIcon(WidgetTester tester) async {
  await Utils.click(tester, IconButton);
}

void main() {
  group('Input password test', () {
    testWidgets(
        'The first view of the password view should show a locked padlock icon and hide the password being entered',
        (WidgetTester tester) async {
      //given
      TextEditingController passwordController = TextEditingController();

      //when
      await Utils.showView(tester, InputPassword(passwordController));

      //then
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);

      TextField input =
          find.byType(TextField).evaluate().single.widget as TextField;
      expect(input.obscureText, true);
    });

    testWidgets(
        'After clicking on the padlock icon, the password should be displayed in plain text and the icon should change to an open padlock',
        (WidgetTester tester) async {
      //given
      TextEditingController passwordController = TextEditingController();

      //when
      await Utils.showView(tester, InputPassword(passwordController));
      await clickLockIcon(tester);

      //then
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.byIcon(Icons.lock_open), findsOneWidget);
      TextField input =
          find.byType(TextField).evaluate().single.widget as TextField;
      expect(input.obscureText, false);
    });

    testWidgets(
        'Clicking on the padlock icon again should hide the open view of the password',
        (WidgetTester tester) async {
      //given
      TextEditingController passwordController = TextEditingController();

      //when
      await Utils.showView(tester, InputPassword(passwordController));
      await clickLockIcon(tester);
      await clickLockIcon(tester);

      //then
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
      TextField input =
          find.byType(TextField).evaluate().single.widget as TextField;
      expect(input.obscureText, true);
    });
  });
}
