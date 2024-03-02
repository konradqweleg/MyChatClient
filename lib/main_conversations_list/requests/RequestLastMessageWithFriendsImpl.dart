import 'package:my_chat_client/requests/requests_url.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../login_and_registration/common/result.dart';
import 'RequestLastMessage.dart';

class RequestLastMessagesWithFriendsImpl extends RequestLastMessage {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> getLastMessagesWithFriends(int idUser) async {
    print(RequestsURL.getLastMessagesWithFriends+idUser.toString());

    Result a =   await httpHelperAuth.get(RequestsURL.getLastMessagesWithFriends+779.toString());

    print(a);
    return a;

  }

}