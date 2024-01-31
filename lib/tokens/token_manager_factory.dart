
import 'package:my_chat_client/tokens/saved_auth_data.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:my_chat_client/tokens/token_manager_impl.dart';

class TokenManagerFactory {

  static TokenManager getTokenManager() {
    TokenManager tokenManager = TokenManagerImpl( SavedAuthData());
    return tokenManager;
  }
}