import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/main_conversations_list/add_friend/request_find_user_matching_pattern.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../requests/requests_url.dart';

class RequestFindUserMatchingPatternImpl extends RequestFindUserMatchingPattern {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> requestFindUserMatchingPattern(String pattern) async {
    Result userFriends =   await httpHelperAuth.get(RequestsURL.findUserMatchingPattern+pattern.toString());
    return userFriends;
  }

}