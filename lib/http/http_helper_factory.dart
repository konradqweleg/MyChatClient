import 'package:http/http.dart' as http;
import 'package:my_chat_client/http/http_helper_auth_impl.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import '../tokens/token_manager_factory.dart';
import 'http_helper_auth.dart';

class HttpHelperFactory {
  static HttpHelperAuth createHttpHelperAuth() {
    TokenManager tokenManager = TokenManagerFactory.getTokenManager();
    var client = http.Client();
    return HttpHelperAuthImpl(client, tokenManager);
  }
}
