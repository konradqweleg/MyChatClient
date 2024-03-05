import 'package:get_it/get_it.dart';
import 'package:my_chat_client/login_and_registration/login/request/request_is_correct_tokens.dart';

import '../../../http/http_helper_auth.dart';
import '../../../http/http_helper_factory.dart';
import '../../../http/request_status/auth_request_status.dart';
import '../../../requests/requests_url.dart';
import '../../common/result.dart';

class RequestIsCorrectTokensHttp extends RequestIsCorrectTokens {
  final GetIt _getIt = GetIt.instance;

  RequestIsCorrectTokensHttp(){
    httpHelperAuth = _getIt<HttpHelperAuth>();
  }

  //_getIt<RequestIsCorrectTokens>().isCorrectSavedTokens()

  HttpHelperAuth? httpHelperAuth ;//= HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<bool> isCorrectSavedTokens() async {
    Result isValidTryUsageAlreadySavedTokens = await httpHelperAuth!.get(RequestsURL.isValidTokens);

    if (isValidTryUsageAlreadySavedTokens.isSuccess()) {
      return true;
    } else {
      return _isRedirectToMainConversationViewWhenNotRequestResultRedirectToLoginPage(isValidTryUsageAlreadySavedTokens);
    }
  }

  bool _isRedirectToMainConversationViewWhenNotRequestResultRedirectToLoginPage(Result isValidTryUsageAlreadySavedTokens) {
    return isValidTryUsageAlreadySavedTokens.data != AuthRequestStatus.redirectToLoginPage;
  }


}
