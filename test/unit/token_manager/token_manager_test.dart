import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/tokens/saved_token_status.dart';
import 'package:my_chat_client/tokens/token_manager.dart';


import '../auth/auth_request_test.mocks.dart';
import '../util/mock_token_manager_factory.dart';





@GenerateNiceMocks([MockSpec<TokenManager>()])
void main() {
  group('TokenManagerTests', () {

    test('When there are no saved tokens, checking the status of saved tokens should return no saved tokens', () async {
      //given
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getNoAccessAnyTokens();

      //when
      Result<SavedTokenStatus> result = await mockTokenManager.checkSavedTokens();

      //then
      expect(result.isSuccess() && result.getData() == SavedTokenStatus.noAccessAnyTokens, true);
    });




  });
}