import 'package:my_chat_client/main_conversations_list/requests/request_get_user_friends.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../login_and_registration/common/result.dart';
import '../../requests/requests_url.dart';

class RequestGetUserFriendsImpl extends RequestGetUserFriends {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> getUserFriends(int idUser) async {
    Result userFriends =   await httpHelperAuth.get(RequestsURL.getUserFriends+idUser.toString());
    return userFriends;
  }

}
