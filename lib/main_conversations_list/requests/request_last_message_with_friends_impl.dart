import 'package:my_chat_client/requests/requests_url.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../login_and_registration/common/result.dart';
import 'request_last_message.dart';

class RequestLastMessagesWithFriendsImpl extends RequestLastMessage {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) async {
    Result lastMessagesWithFriends =   await httpHelperAuth.get(RequestsURL.getLastMessagesWithFriends+idUser.toString());
    return lastMessagesWithFriends;

  }

}