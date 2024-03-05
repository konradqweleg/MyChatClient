import 'package:my_chat_client/tokens/saved_token_status.dart';
import '../login_and_registration/common/result.dart';

abstract class TokenManager {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  void saveAccessToken(String token);
  void saveRefreshToken(String token);
  Future<Result<SavedTokenStatus>> checkSavedTokens();
  Future<void> deleteAccessToken();
  Future<void> deleteRefreshToken();
  void clear();
}