import '../../model/friend.dart';

abstract class FriendsService {
  Future<List<Friend>> getFriends();
  Future<void> addFriend(Friend friend);
  Future<void> removeFriend(Friend friend);
}