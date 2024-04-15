import 'package:my_chat_client/conversation/requests/model/message_data.dart';

import '../../login_and_registration/common/result.dart';

abstract class SendMessageRequest {
  Future<Result> sendMessage(MessageData idUser);
}