
import 'package:my_chat_client/database/create_db/platform_specific_init_db/platform_specific_init_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
class PlatformSpecificInitDbWindows implements PlatformSpecificInitDb {
  @override
  void platformSpecificInitDbCode() {
     sqfliteFfiInit();
     databaseFactory = databaseFactoryFfi;
  }


}
