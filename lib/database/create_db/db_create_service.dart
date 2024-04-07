import 'dart:io' show Platform;
import 'package:my_chat_client/database/create_db/platform_specific_init_db/platform_specific_init_db.dart';
import 'package:my_chat_client/database/create_db/platform_specific_init_db/platform_specific_init_db_windows.dart';
import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<void> deleteDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, _nameDbFile);
    await deleteDatabase(dbPath);
  }


  void runCodeInitialiseSqLiteDbSpecificOnPlatform() {
    if (Platform.isWindows) {
      PlatformSpecificInitDb platformSpecificInitDb = PlatformSpecificInitDbWindows();
      platformSpecificInitDb.platformSpecificInitDbCode();
    }
  }

  static Database? database;
  Future<Database> initializeDB() async {

    if(database != null) {
      return database!;
    }
   // await deleteDB();

    runCodeInitialiseSqLiteDbSpecificOnPlatform();

    String path = await getDatabasesPath();

    database = await openDatabase(
      join(path, _nameDbFile),
      onCreate: (database, version) async {
        await createFriendsTable(database);
        await createInfoAboutMeTable(database);
        await createMessageTable(database);
      },
      onConfigure: (Database db) async {
        // Tylko specyficzna platforma wykonuj
        //await db.execute('PRAGMA busy_timeout = 5000');
      },
      version: _versionDb,
    );
//    await deleteDB();
    return database!;
  }

  Future<Database> initializeDBAlwaysOpenNewConnection() async {

    runCodeInitialiseSqLiteDbSpecificOnPlatform();

    String path = await getDatabasesPath();

    database = await openDatabase(
      join(path, _nameDbFile),
      onCreate: (database, version) async {
        await createFriendsTable(database);
        await createInfoAboutMeTable(database);
        await createMessageTable(database);
      },
      version: _versionDb,
    );

    return database!;
  }
}
