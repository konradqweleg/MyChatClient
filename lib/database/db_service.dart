import 'package:my_chat_client/database/create_db/db_create_service.dart';
import 'package:my_chat_client/database/schema/friend_schema.dart';
import 'package:sqflite/sqflite.dart';

import 'model/friend.dart';

class DbService{
  DbCreateService dbCreateService = DbCreateService();


 Future<int?> insertFriend(Friend friend) async {
    Database db = await dbCreateService.initializeDB();
    return await db.insert(FriendSchema.tableName, friend.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Friend>> getFriends() async {
    Database db = await dbCreateService.initializeDB();
    List<Map<String, dynamic>> maps = await db.query(FriendSchema.tableName);
    return List.generate(maps.length, (i) {
      return Friend(
        idFriend: maps[i][FriendSchema.idFriendCol],
        name: maps[i][FriendSchema.nameCol],
        surname: maps[i][FriendSchema.surnameCol],
      );
    });
  }

  Future<void> updateFriend(Friend friend) async {
    Database db = await dbCreateService.initializeDB();
    await db.update(
      FriendSchema.tableName,
      friend.toMap(),
      where: '${FriendSchema.idFriendCol} = ?',
      whereArgs: [friend.idFriend],
    );
  }

  Future<void> deleteFriend(int id) async {
    Database db = await dbCreateService.initializeDB();
    await db.delete(
      FriendSchema.tableName,
      where: '${FriendSchema.idFriendCol} = ?',
      whereArgs: [id],
    );
  }
}