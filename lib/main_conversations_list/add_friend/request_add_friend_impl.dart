import 'dart:convert';

import 'package:my_chat_client/main_conversations_list/add_friend/create_friends_data.dart';
import 'package:my_chat_client/main_conversations_list/add_friend/request_add_friend.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../login_and_registration/common/result.dart';
import '../../requests/requests_url.dart';

class RequestAddFriendImpl implements RequestAddFriend {
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> requestAddFriend(int idFirstUser, int idSecondUser) async {
    CreateFriendsData createFriendsData = CreateFriendsData(idFirstUser, idSecondUser);
    var messageJSON = jsonEncode(createFriendsData);
    Result result =   await httpHelperAuth.post(RequestsURL.addFriend, messageJSON);

    return result;
  }
}
