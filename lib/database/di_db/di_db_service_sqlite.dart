import 'package:get_it/get_it.dart';
import 'package:my_chat_client/main_conversations_list/requests/request_last_message.dart';
import 'package:my_chat_client/main_conversations_list/requests/request_last_message_with_friends_impl.dart';

import '../db_services/friends/friends_service.dart';
import '../db_services/friends/friends_service_sqlite.dart';
import '../db_services/info_about_me/info_about_me_service.dart';
import '../db_services/info_about_me/info_about_me_service_sqlite.dart';
import '../db_services/messages/messages_service.dart';
import '../db_services/messages/messages_service_sqlite.dart';
import 'di_db_service.dart';

class DiDbServiceSqlite extends DiDbService {
  static GetIt getIt = GetIt.instance;
  @override
  void register() {
    getIt.registerSingleton<FriendsService>(FriendServiceSqlite());
    getIt.registerSingleton<InfoAboutMeService>(InfoAboutMeServiceSqlite());
    getIt.registerSingleton<MessagesService>(MessagesServiceSqLite());
    getIt.registerSingleton<RequestLastMessage>(RequestLastMessagesWithFriendsImpl());
  }

}