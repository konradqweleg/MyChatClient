import 'package:my_chat_client/database/create_db/db_create_service.dart';
import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:my_chat_client/database/schema/message_schema.dart';
import 'package:sqflite/sqflite.dart';

class DbUtils {
  Future<void> cleanAllDataInDatabase() async {

    DbCreateService dbCreateService = DbCreateService();


    Database db = await dbCreateService.initializeDB();

    await db.execute(FriendSchema.clearAllDataQuery);
    await db.execute(InfoAboutMeSchema.clearAllDataQuery);
    await db.execute(MessageSchema.clearAllDataQuery);

  }
}
