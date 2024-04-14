import '../../login_and_registration/common/result.dart';

abstract class RequestGetUserFriends {
  Future<Result> getUserFriends(int idUser);
}
