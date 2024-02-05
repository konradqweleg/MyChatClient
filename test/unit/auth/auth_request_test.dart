import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:my_chat_client/http/http_helper_auth.dart';
import 'package:my_chat_client/http/http_helper_auth_impl.dart';
import 'package:my_chat_client/http/request_status/auth_request_status.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:http/testing.dart';
import '../util/mock_token_manager_factory.dart';
import 'auth_request_test.mocks.dart';
import 'mock_http_client_factory.dart';




@GenerateNiceMocks([MockSpec<HttpClient >(), MockSpec<TokenManager>()])
void main() {
  group('HttpHelperAuthImpl', () {

    test('When the access token is valid, the request should return the correct response for the protected resource', () async {
     //given
     MockClient mockClient = MockHttpClientFactory().withRequestAndResponse('https://examplerequest', 'SuccessRequest', 200);
     MockTokenManager mockTokenManager = MockTokenManagerFactory().getAccessibleAllTokens();
     HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockClient, mockTokenManager);

     //when
     Result result = await httpHelperAuth.get('https://exampleRequest');

     //then
     expect(result.isSuccess() && result.getData() =='SuccessRequest', true);
    });


    test('When there are no saved tokens, the request should return a redirect to the login page', () async {
      //given
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getNoAccessAnyTokens();
      MockClient mockHttpClient = MockHttpClientFactory().withRequestAndResponse('https://examplerequest', 'SuccessRequest', 200);
      HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockHttpClient, mockTokenManager);

      //when
      Result result = await httpHelperAuth.get('https://exampleRequest');

      //then
      expect(result.isError() && result.getData() == AuthRequestStatus.redirectToLoginPage, true);
    });

    test('When we have an expired access token but a valid refresh token, the request should refresh the access token after failure and execute correctly', () async {
      //given
      MockClient mockClient = MockHttpClientFactory().withMockReconnectingSuccess();
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getAccessibleAllTokens();
      HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockClient, mockTokenManager);

      //when
      Result result = await httpHelperAuth.get('https://exampleRequest');

      //then
      expect(result.isSuccess() && result.getData() =='Correct response', true);
    });


    test('When both tokens have expired, the request should return a redirect to the login page', () async {
      //given
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getAccessibleAllTokens();
      MockClient mockHttpClient = MockHttpClientFactory().withMockReconnectingFail();
      HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockHttpClient, mockTokenManager);

      //when
      Result result = await httpHelperAuth.get('https://exampleRequest');
      //then
      expect(result.isError() && result.getData() == AuthRequestStatus.redirectToLoginPage, true);
    });


  });
}