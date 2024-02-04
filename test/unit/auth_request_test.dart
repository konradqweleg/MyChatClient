import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_chat_client/http/http_helper_auth.dart';
import 'package:my_chat_client/http/http_helper_auth_impl.dart';
import 'package:my_chat_client/http/request_data/acess_token_data.dart';
import 'package:my_chat_client/http/request_status/auth_request_status.dart';

import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/requests/requests_url.dart';
import 'package:my_chat_client/tokens/saved_token_status.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:http/http.dart' as http;

import 'auth_request_test.mocks.dart';

import 'package:http/testing.dart';

class MockHttpClientFactory {

  MockClient withRequestAndResponse(String url, String response,
      int statusCode) {
    return MockClient((request) async {
      if (request.url.toString().startsWith(url)) {
        return Response(response, statusCode,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }
      return throw Exception('failed');
    });
  }



  MockClient withMockReconnectingSuccess (String url, String response, int statusCode) {
    int requestCount = 0;
    return MockClient((request) async {
      requestCount++;

      print("Request count: $requestCount");

      if(requestCount == 3){
        return Response("Ok", 200, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      print("Request url: ${request.url.toString()} vs ${RequestsURL.refreshToken}");
      if(request.url.toString().startsWith(RequestsURL.refreshToken)){
        print("timeout");
        return Response("{\"token\":\"tokenData\"}", 200, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      if (request.url.toString().startsWith(url)) {
        print("Request url: ${request.url.toString()}");
        return Response(response, statusCode, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }
      return throw Exception('failed');
    });
  }

}

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


}

@GenerateNiceMocks([MockSpec<HttpClient >(), MockSpec<TokenManager>()])
void main() {
  group('HttpHelperAuthImpl', () {




    test('When we have a valid access token, the request should return the correct response', () async {
     //given
     MockClient mockClient = MockHttpClientFactory().withRequestAndResponse('https://examplerequest', 'SuccessRequest', 200);
     MockTokenManager mockTokenManager = MockTokenManagerFactory().getAccessibleAllTokens();

     HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockClient, mockTokenManager);

     //when
     Result result = await httpHelperAuth.get('https://exampleRequest');

     //then
     expect(result.isSuccess() && result.getData() =='SuccessRequest', true);
    });


    test('When we do not have access token and refresh token all requests should return go to login page', () async {
      //given
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getNoAccessAnyTokens();
      MockClient mockHttpClient = MockHttpClientFactory().withRequestAndResponse('https://examplerequest', 'SuccessRequest', 200);

      HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockHttpClient, mockTokenManager);

      //when
      Result result = await httpHelperAuth.get('https://exampleRequest');

      //then
      expect(result.isError() && result.getData() == AuthRequestStatus.redirectToLoginPage, true);
    });

    test('When we have a valid access token, but the request returns 401, method should make refresh access token request', () async {
      //given



      MockClient mockClient = MockHttpClientFactory().withMockReconnectingSuccess('https://examplerequest', 'Unauthorized', 401);
      MockTokenManager mockTokenManager = MockTokenManagerFactory().getAccessibleAllTokens();

      HttpHelperAuth httpHelperAuth = HttpHelperAuthImpl(mockClient, mockTokenManager);

      //when
      Result result = await httpHelperAuth.get('https://exampleRequest');
      print(result);

      //then
      expect(result.isSuccess() && result.getData() =='Ok', true);
    });



  });
}