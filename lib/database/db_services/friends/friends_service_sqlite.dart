import 'package:my_chat_client/database/model/friend.dart';

import 'friends_service.dart';

class FriendServiceSqlite implements FriendsService {
  @override
  Future<void> addFriend(String userId, String friendId) {
    // TODO: implement addFriend
    throw UnimplementedError();
  }

  @override
  Future<List<Friend>> getFriends(String userId) {
    // TODO: implement getFriends
    throw UnimplementedError();
  }

  @override
  Future<void> removeFriend(String userId, String friendId) {
    // TODO: implement removeFriend
    throw UnimplementedError();
  }

}
