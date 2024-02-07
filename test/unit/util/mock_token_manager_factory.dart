import 'package:mockito/mockito.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/tokens/saved_token_status.dart';

import '../auth/auth_request_test.mocks.dart';





class MockTokenManagerFactory{
  MockTokenManager getAccessibleAllTokens(){
    MockTokenManager mockTokenManager = MockTokenManager();
    when(mockTokenManager.checkSavedTokens()).thenAnswer((_)  {
      return Future(() => Result.success(SavedTokenStatus.accessibleAccessToken)) ;
    });

    when(mockTokenManager.getAccessToken()).thenAnswer((_) => Future.value('access_token'));
    when(mockTokenManager.getRefreshToken()).thenAnswer((_) => Future.value('refresh_token'));
    return mockTokenManager;
  }

  MockTokenManager getNoAccessAnyTokens(){
    MockTokenManager mockTokenManager = MockTokenManager();
    when(mockTokenManager.checkSavedTokens()).thenAnswer((_)  {
      return Future(() => Result.success(SavedTokenStatus.noAccessAnyTokens)) ;
    });

    when(mockTokenManager.getAccessToken()).thenAnswer((_) => Future.value(null));
    return mockTokenManager;
  }

  MockTokenManager getAccessibleRefreshToken(){
    MockTokenManager mockTokenManager = MockTokenManager();
    when(mockTokenManager.checkSavedTokens()).thenAnswer((_)  {
      return Future(() => Result.success(SavedTokenStatus.accessibleRefreshToken)) ;
    });

    when(mockTokenManager.getRefreshToken()).thenAnswer((_) => Future.value('refresh_token'));
    return mockTokenManager;
  }


}