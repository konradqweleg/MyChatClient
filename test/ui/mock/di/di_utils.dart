import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service_sqlite.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service_sqlite.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service_sqlite.dart';
import 'package:my_chat_client/di/di_factory_impl.dart';
import 'package:my_chat_client/di/register_di.dart';

class DiUtils{
  static final GetIt _getIt = GetIt.instance;

  static Future<void> _unregisterAll() async {
    await _getIt.reset();
  }

  static GetIt get() {
    GetIt.instance.allowReassignment = true;
    return _getIt;
  }

  static Future<void> registerDefaultDi() async {
    await _unregisterAll();
    RegisterDI registerDI = RegisterDI(DiFactoryImpl());
    registerDI.register();
  }

}