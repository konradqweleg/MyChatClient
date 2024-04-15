import 'dart:convert';

import 'package:my_chat_client/conversation/requests/send_message_request.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';

import '../../http/http_helper_auth.dart';
import '../../http/http_helper_factory.dart';
import '../../requests/requests_url.dart';
import 'model/message_data.dart';

class SendMessageRequestImpl implements SendMessageRequest {

  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();

  @override
  Future<Result> sendMessage(MessageData message) async {
    var messageJSON = jsonEncode(message);
    Result userFriends =   await httpHelperAuth.post(RequestsURL.postSendMessage, messageJSON);
    return userFriends;

  }



}