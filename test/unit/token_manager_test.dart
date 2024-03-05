import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/tokens/saved_auth_data.dart';
import 'package:my_chat_client/tokens/saved_token_status.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:my_chat_client/tokens/token_manager_impl.dart';


class SavedAuthDataMock implements SavedAuthData {
  String? _accessToken;
  String? _refreshToken;
  String? _email;
  String? _password;

  @override
  Future<void> deleteAccessToken() {
    _accessToken = null;
    return Future.value();
  }

  @override
  void deleteAllTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  @override
  void deleteEmail() {
    _email = null;
  }

  @override
  void deletePassword() {
    _password = null;
  }

  @override
  Future<void> deleteRefreshToken() {
    _refreshToken = null;
    return Future.value();
  }

  @override
  Future<String?> getAccessToken() {
    return Future(() => _accessToken);
  }

  @override
  Future<String?> getEmail() {
    return Future(() => _email);
  }

  @override
  Future<String?> getPassword() {
    return Future(() => _password);
  }

  @override
  Future<String?> getRefreshToken() {
    return Future(() => _refreshToken);
  }

  @override
  void saveAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  @override
  void saveEmail(String email) {
    _email = email;
  }

  @override
  void savePassword(String password) {
    _password = password;
  }

  @override
  void saveRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
  }

}

void main() {
  group('TokenManagerImplTest', () {


    test('When saved access token access token should be accessible', () async {

      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveAccessToken('access_token');
      //then
      expect('access_token', await tokenManager.getAccessToken());

    });

    test('When saved refresh token refresh token should be accessible', () async {
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveRefreshToken('refresh_token');
      //then
      expect('refresh_token', await tokenManager.getRefreshToken());

    });

    test('When access token is unavailable and refresh token is available should return accessible refresh token', () async {
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveRefreshToken('refresh_token');
      //then
      expect(Result.success(SavedTokenStatus.accessibleRefreshToken), await tokenManager.checkSavedTokens());

    });

    test('When access token is unavailable and refresh token is unavailable should return no access any tokens', () async {
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      //then
      expect(Result.success(SavedTokenStatus.noAccessAnyTokens), await tokenManager.checkSavedTokens());

    });

    test('When access token is available and refresh token is unavailable should return accessible access token', () async {
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveAccessToken('access_token');
      //then
      expect(Result.success(SavedTokenStatus.accessibleAccessToken), await tokenManager.checkSavedTokens());

    });








  });
}