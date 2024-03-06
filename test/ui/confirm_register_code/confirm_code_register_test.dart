
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/common/exit_button.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/common/button/main_action_button.dart';
import 'package:my_chat_client/login_and_registration/confirm_code/confirm_register_code.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response_status.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_chat_client/style/main_style.dart';
import '../mock/di/di_utils.dart';
import '../mock/di/login/mock_saved_tokens_request/mock_request_is_correct_tokens_bad.dart';


class Utils {
  static Future<void> showView(WidgetTester tester, Widget view) async {
    await tester.pumpWidget(MaterialApp(
      title: "MY CHAT",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MainAppStyle.mainColorApp),
        useMaterial3: true,
      ),
      home: Scaffold(body: view),
    ));
    await tester.pumpAndSettle();
  }

  static Future<void> click(
      WidgetTester tester, Type typeClickedElement) async {
    await tester.tap(find.byType(typeClickedElement));
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> clickButtonFind(
      WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pump();
    await tester.pumpAndSettle();
  }



  static Future<void> enterText(
      WidgetTester tester, Finder element, String text) async {
    await tester.tap(element);
    await tester.pump();

    await tester.pump();
    await tester.enterText(element, text);
    await tester.pump();
    await tester.pumpAndSettle();
  }

  static Future<void> backOsButton(WidgetTester tester) async {
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pump();
    await tester.pumpAndSettle();
  }
}




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

class RegisterUserRequestMock extends RegisterUserRequest{
  @override
  Future<Result> register(UserRegisterData userRegisterData) {
    throw Future.value(Result.success(RegisterResponseStatus.ok));
  }

}



void main() {
  group('ConfirmCodeRegister', () {

    setUp(() async => DiUtils.registerDefaultDi() );

    testWidgets(
        'Checking that the confirm create account view contains all the required elements',
        (WidgetTester tester) async {
      //given
      //when
      UserRegisterData registerData =
          UserRegisterData("", "name", "surname", "password");
      await Utils.showView(tester, ConfirmRegisterCode(registerData));

      //then
      expect(find.text("Enter code"), findsOneWidget);
      expect(
          find.text(
              "We sent you an email with a 4-digit code. Enter it to create an account. Resend code",
              findRichText: true),
          findsOneWidget);
      expect(find.text("Register"), findsOneWidget);
      expect(find.byType(ExitButton), findsOneWidget);
    });

    testWidgets(
        'Checking that the ui back button takes you to the login screen.',
        (WidgetTester tester) async {
      //given
      DiUtils.get().registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());

      UserRegisterData registerData =
          UserRegisterData("", "name", "surname", "password");
      await Utils.showView(tester, ConfirmRegisterCode(registerData));
      //when
      await clickExitButton(tester);

      //then
      expect(find.byType(Login), findsOneWidget);
    });

    //TO DO
    // testWidgets(
    //     "Checking that the os back button takes you to the login screen.",
    //     (tester) async {
    //   //given
    //
    //   //Transition from login view to registration
    //   await Utils.showView(tester, const Login());
    //   await Utils.click(tester, CreateNewAccountButton);
    //
    //   //Transition from register view to confirm code register
    //   await Utils.enterText(
    //       tester, find.byType(TextFormField).first, "correct@mail.format");
    //   await Utils.enterText(tester, find.byType(TextFormField).at(1), "name");
    //   await Utils.enterText(
    //       tester, find.byType(TextFormField).at(2), "surname");
    //   await Utils.enterText(
    //       tester, find.byType(TextFormField).at(3), "password");
    //
    //
    //
    //   await Utils.click(tester, MainActionButton);
    //
    //   //when
    //   await Utils.backOsButton(tester);
    //
    //   //then
    //   expect(find.byType(Login), findsOneWidget);
    // });
    //


    testWidgets(
        "When you clicked the registration button without entering the code, the system should display a message asking you to enter the code",
        (tester) async {
      //given
      UserRegisterData registerData =
          UserRegisterData("", "name", "surname", "password");
      await Utils.showView(tester, ConfirmRegisterCode(registerData));

      //when
      await enterConfirmCode(tester, "");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Please enter code"), findsOneWidget);
      expect(find.byType(ConfirmRegisterCode), findsOneWidget);
    });



    testWidgets(
        "When the registration button was clicked with a code that was too short, the system should display a message stating that the code was given too short",
        (tester) async {
      //given
      UserRegisterData registerData =
          UserRegisterData("", "name", "surname", "password");
      await Utils.showView(tester, ConfirmRegisterCode(registerData));

      //when
      await enterConfirmCode(tester, "34");
      await clickRegisterButton(tester);

      //then
      expect(find.text("Not enough characters in the code"), findsOneWidget);
      expect(find.byType(ConfirmRegisterCode), findsOneWidget);
    });


  });
}
