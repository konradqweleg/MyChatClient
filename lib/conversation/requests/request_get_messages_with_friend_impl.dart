import 'package:my_chat_client/conversation/requests/request_get_messages_with_friend.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../requests/requests_url.dart';

class RequestGetMessagesWithFriendsImpl extends RequestGetMessagesWithFriend {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> getMessagesWithFriend(int idUser,int idFriend) async {
    Result userFriends =  await httpHelperAuth.get("${RequestsURL.getMessagesWithFriend}$idUser&idFriend=$idFriend");
    return userFriends;
  }


}