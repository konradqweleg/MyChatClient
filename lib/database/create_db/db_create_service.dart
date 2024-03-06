import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
class DbCreateService {

  static const _nameDbFile = 'database.db';
  static const _versionDb = 1;

  Future<void> createFriendsTable(Database database) async {
    await database.execute(
      FriendSchema.createTableQuery,
    );
  }

  Future<void> createInfoAboutMeTable(Database database) async {
    await database.execute(
      InfoAboutMeSchema.createTableQuery,
    );
  }

  Future<void> createMessageTable(Database database) async {
    await database.execute(
      MessageSchema.createTableQuery,
    );
  }

  Future<Database> initializeDB() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, _nameDbFile),
      onCreate: (database, version) async {
        createFriendsTable(database);
        createInfoAboutMeTable(database);
        createMessageTable(database);
      },
      version: _versionDb,
    );
  }
}