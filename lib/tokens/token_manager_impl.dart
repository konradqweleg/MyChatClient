import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/tokens/saved_auth_data.dart';
import 'package:my_chat_client/tokens/saved_token_status.dart';
import 'package:my_chat_client/tokens/token_manager.dart';

class TokenManagerImpl extends TokenManager {
  TokenManagerImpl(this._savedAuthData);

  final SavedAuthData _savedAuthData;

  @override
  void clear() {
    _savedAuthData.deleteAllTokens();
  }

  @override
  Future<String?> getAccessToken() {
   return _savedAuthData.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() {
   return _savedAuthData.getRefreshToken();
  }

  @override
  void saveAccessToken(String token) {
    _savedAuthData.saveAccessToken(token);
  }

  @override
  void saveRefreshToken(String token) {
    _savedAuthData.saveRefreshToken(token);
  }



  @override
  Future<Result<SavedTokenStatus>> checkSavedTokens() async {
    String? accessToken = await  getAccessToken();
    String? refreshToken = await getRefreshToken();

    print(accessToken) ;
    print(refreshToken);


    if (accessToken != null) {
      return Result.success(SavedTokenStatus.accessibleAccessToken);
    } else if (accessToken == null && refreshToken != null) {
      return Result.success(SavedTokenStatus.accessibleRefreshToken);
    } else if (accessToken == null && refreshToken == null) {
      return Result.success(SavedTokenStatus.noAccessAnyTokens);
    } else {
      return Result.error(SavedTokenStatus.error);
    }
  }

  @override
  Future<void> deleteAccessToken() async {
    await _savedAuthData.deleteAccessToken();
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _savedAuthData.deleteRefreshToken();
  }

}