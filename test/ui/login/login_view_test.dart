import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';
import 'package:my_chat_client/login_and_registration/login/button/create_new_account.dart';
import 'package:my_chat_client/login_and_registration/login/button/reset_password_button.dart';
import 'package:my_chat_client/login_and_registration/login/di/login_di_register.dart';
import 'package:my_chat_client/login_and_registration/login/login.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';
import 'package:my_chat_client/login_and_registration/register/register.dart';
import 'package:my_chat_client/login_and_registration/reset_password/reset_password.dart';
import 'package:my_chat_client/main_conversations_list/main_conversation_list.dart';

import '../helping/utils.dart';



Future<void> clickCreateNewAccountButton(WidgetTester tester) async{
 await Utils.click(tester, CreateNewAccountButton);
}

Future<void> clickResetPassword(WidgetTester tester) async{
  await Utils.click(tester, ResetPasswordButton);
}


class MockIsCorrectSavedTokensCorrectTokens implements RequestIsCorrectTokens {
  @override
  Future<bool> isCorrectSavedTokens() {
    return Future.value(true);
  }
}

class MockLoginDiRegisterCorrectSavedTokens implements LoginDiRegister {
  static final GetIt _getIt = GetIt.instance;

  @override
  void register() {
    _registerRequests();
  }

  void _registerRequests(){
    _getIt.registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensCorrectTokens());
  }
}

class MockDiFactoryImplCorrectSavedTokens implements DiFactoryImpl {

  @override
  LoginDiRegister getDiRegisterForLogin() {
    return MockLoginDiRegisterCorrectSavedTokens();
  }

}


class MockIsCorrectSavedTokensBadTokens implements RequestIsCorrectTokens {
  @override
  Future<bool> isCorrectSavedTokens() {
    return Future.value(false);
  }
}

class MockLoginDiRegisterBadSavedTokens implements LoginDiRegister {
  static final GetIt _getIt = GetIt.instance;

  @override
  void register() {
    _registerRequests();
  }

  void _registerRequests(){
    _getIt.registerSingleton<RequestIsCorrectTokens>(MockIsCorrectSavedTokensBadTokens());
  }
}

class MockDiFactoryImplBadSavedTokens implements DiFactoryImpl {

  @override
  LoginDiRegister getDiRegisterForLogin() {
    return MockLoginDiRegisterBadSavedTokens();
  }

}

void main() {
  group('Login', () {

    testWidgets('The application should remain on the login view when tokens are rejected.',
         (WidgetTester tester) async {
      //given
      RegisterDI registerDI = RegisterDI(MockDiFactoryImplBadSavedTokens());
      registerDI.register();

      //when
      await Utils.showView(tester,  Login());

      //then
      expect(find.byType(Login), findsOneWidget);
    });
    
    
    testWidgets('The application should transition from the login view to the main conversation view when it has valid tokens stored or when their state cannot be determined.',
         (WidgetTester tester) async {
      //given
      RegisterDI registerDI = RegisterDI(MockDiFactoryImplCorrectSavedTokens());
      registerDI.register();

      //when
      await Utils.showView(tester,  Login());

      //then
      expect(find.byType(MainConversationList), findsOneWidget);
    });
    
    
    testWidgets(
        'Checking that the login view contains all the required elements',
        (WidgetTester tester) async {
      //given
      //when
      await Utils.showView(tester,  Login());

      //then
      expect(find.text("Enter your email"), findsOneWidget);
      expect(find.text("Enter your password"), findsOneWidget);
      expect(find.text("Login"), findsOneWidget);
      expect(find.text("CREATE NEW \n ACCOUNT"), findsOneWidget);
      expect(find.text("I FORGOT MY PASSWORD"), findsOneWidget);
      expect(find.text("GOOGLE"), findsOneWidget);
      expect(find.text("FACEBOOK"), findsOneWidget);
    });

    testWidgets(
        "Checking if the back button closes applications on the login screen",
        (tester) async {
      //given
      await Utils.showView(tester,  Login());

      //when
      await Utils.backOsButton(tester);

      //then
      expect(exitCode, 0);
    });

    testWidgets(
        "Account creation button takes you to the account creation view",
        (tester) async {
      //given
      await Utils.showView(tester,  Login());

      //when
      await clickCreateNewAccountButton(tester);

      //then
      expect(find.byType(Register), findsOneWidget);
    });

    testWidgets(
        "Account forgot password button takes you to the reset password view",
        (tester) async {
      //given
      await Utils.showView(tester,  Login());

      //when
      await clickResetPassword(tester);

      //then
      expect(find.byType(ResetPassword), findsOneWidget);
    });
  });
}
