import '../../login_and_registration/common/result.dart';

abstract class RequestAddFriend  {
  Future<Result> requestAddFriend(int idFirstUser, int idSecondUser);
}