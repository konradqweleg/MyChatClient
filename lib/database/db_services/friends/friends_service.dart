import '../../model/friend.dart';

abstract class FriendsService {
  Future<List<Friend>> getFriends(String userId);
  Future<void> addFriend(String userId, String friendId);
  Future<void> removeFriend(String userId, String friendId);
}