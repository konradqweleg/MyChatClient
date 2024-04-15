import '../../login_and_registration/common/result.dart';

abstract class RequestGetMessagesWithFriend  {
  @override
  Future<Result> getMessagesWithFriend(int idUser,int idFriend);

}

