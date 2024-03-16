import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/main_conversations_list/requests/request_last_message.dart';

class MockDownloadLastMessagesWithFriendsReturnEmptyList implements RequestLastMessage {
  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) {
    return Future.value(Result.success("[]"));
  }
}

