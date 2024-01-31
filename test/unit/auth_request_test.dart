import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_chat_client/http/http_helper_auth_impl.dart';
import 'package:my_chat_client/http/request_status/auth_request_status.dart';
import 'package:my_chat_client/cached_auth_data/saved_auth_data.dart';
import 'package:my_chat_client/http/request_refresh_access_token_http.dart';

class MockSavedAuthData extends Mock implements SavedAuthData {}
class MockRequestRefreshAccessTokenHttp extends Mock implements RequestRefreshAccessTokenHttp {}

void main() {
  group('HttpHelperAuthImpl', () {


    // HttpHelperAuthImpl httpHelperAuthImpl;
    // MockSavedAuthData mockSavedAuthData;
    // MockRequestRefreshAccessTokenHttp mockRequestRefreshAccessTokenHttp;
    //
    // setUp(() {
    //   mockSavedAuthData = MockSavedAuthData();
    //   mockRequestRefreshAccessTokenHttp = MockRequestRefreshAccessTokenHttp();
    //   httpHelperAuthImpl = HttpHelperAuthImpl(mockSavedAuthData, mockRequestRefreshAccessTokenHttp);
    // });
    //
    // test('get request with accessible access token returns success', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'valid_access_token');
    //   final result = await httpHelperAuthImpl.get('http://test.com');
    //   expect(result.isSuccess(), true);
    // });
    //
    // test('get request with expired access token returns error', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'expired_access_token');
    //   final result = await httpHelperAuthImpl.get('http://test.com');
    //   expect(result.isError(), true);
    //   expect(result.getData(), AuthRequestStatus.accessTokenExpired);
    // });
    //
    // test('post request with accessible access token returns success', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'valid_access_token');
    //   final result = await httpHelperAuthImpl.post('http://test.com', {'key': 'value'});
    //   expect(result.isSuccess(), true);
    // });
    //
    // test('post request with expired access token returns error', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'expired_access_token');
    //   final result = await httpHelperAuthImpl.post('http://test.com', {'key': 'value'});
    //   expect(result.isError(), true);
    //   expect(result.getData(), AuthRequestStatus.accessTokenExpired);
    // });
    //
    // test('put request with accessible access token returns success', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'valid_access_token');
    //   final result = await httpHelperAuthImpl.put('http://test.com', {'key': 'value'});
    //   expect(result.isSuccess(), true);
    // });
    //
    // test('put request with expired access token returns error', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'expired_access_token');
    //   final result = await httpHelperAuthImpl.put('http://test.com', {'key': 'value'});
    //   expect(result.isError(), true);
    //   expect(result.getData(), AuthRequestStatus.accessTokenExpired);
    // });
    //
    // test('delete request with accessible access token returns success', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'valid_access_token');
    //   final result = await httpHelperAuthImpl.delete('http://test.com', {'key': 'value'});
    //   expect(result.isSuccess(), true);
    // });
    //
    // test('delete request with expired access token returns error', () async {
    //   when(mockSavedAuthData.getAccessToken()).thenAnswer((_) async => 'expired_access_token');
    //   final result = await httpHelperAuthImpl.delete('http://test.com', {'key': 'value'});
    //   expect(result.isError(), true);
    //   expect(result.getData(), AuthRequestStatus.accessTokenExpired);
    // });
    //
    // test('refresh access token with valid refresh token returns success', () async {
    //   when(mockSavedAuthData.getRefreshToken()).thenAnswer((_) async => 'valid_refresh_token');
    //   when(mockRequestRefreshAccessTokenHttp.refreshAccessToken(any)).thenAnswer((_) async => Result.success('new_access_token'));
    //   final result = await httpHelperAuthImpl._repeatGetRequestWithRefreshedAccessToken(_TypeOfRequest.get, 'http://test.com', null, Duration(seconds: 3));
    //   expect(result.isSuccess(), true);
    // });
    //
    // test('refresh access token with invalid refresh token returns error', () async {
    //   when(mockSavedAuthData.getRefreshToken()).thenAnswer((_) async => 'invalid_refresh_token');
    //   when(mockRequestRefreshAccessTokenHttp.refreshAccessToken(any)).thenAnswer((_) async => Result.error('error'));
    //   final result = await httpHelperAuthImpl._repeatGetRequestWithRefreshedAccessToken(_TypeOfRequest.get, 'http://test.com', null, Duration(seconds: 3));
    //   expect(result.isError(), true);
    // });
  });
}