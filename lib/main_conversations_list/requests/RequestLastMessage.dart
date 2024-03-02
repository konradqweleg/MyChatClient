import 'package:my_chat_client/login_and_registration/common/result.dart';

abstract class RequestLastMessage {
  Future<Result> getLastMessagesWithFriends(int idUser);
}