import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/tokens/saved_auth_data.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:my_chat_client/tokens/token_manager_factory.dart';
import 'package:my_chat_client/tokens/token_manager_impl.dart';



class SavedAuthDataMock implements SavedAuthData {
  String? _accessToken;
  String? _refreshToken;
  String? _email;
  String? _password;

  @override
  void deleteAccessToken() {
    _accessToken = null;
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
  void deleteRefreshToken() {
    _refreshToken = null;
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

    //setUp(() => TokenManagerFactory.getTokenManager().clear());


    test('When saved access token access token should be accessible', () async {
      WidgetsFlutterBinding.ensureInitialized();
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveAccessToken('access_token');
      //then
      expect('access_token', await tokenManager.getAccessToken());

    });

    test('When saved refresh token refresh token should be accessible', () async {
      WidgetsFlutterBinding.ensureInitialized();
      //given
      TokenManager tokenManager = TokenManagerImpl(SavedAuthDataMock());
      //when
      tokenManager.saveRefreshToken('refresh_token');
      //then
      expect('refresh_token', await tokenManager.getRefreshToken());

    });








  });
}