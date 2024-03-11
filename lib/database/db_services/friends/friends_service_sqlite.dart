import 'package:my_chat_client/database/model/friend.dart';
import 'package:my_chat_client/database/create_db/db_create_service.dart';
import '../../schema/friend_schema.dart';
import 'friends_service.dart';
import 'package:sqflite/sqflite.dart';

class FriendServiceSqlite implements FriendsService {
  DbCreateService dbCreateService = DbCreateService();

  @override
  Future<void> addFriend(Friend friend) async {
    Database db = await dbCreateService.initializeDB();
    await db.insert(FriendSchema.tableName, friend.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Friend>> getFriends() async {
    return dbCreateService.initializeDB().then((db) {
      return db.query(FriendSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return List.generate(maps.length, (i) {
        return Friend(
          idFriend: maps[i][FriendSchema.idFriendCol],
          name: maps[i][FriendSchema.nameCol],
          surname: maps[i][FriendSchema.surnameCol],
        );
      });
    });
  }

  @override
  Future<void> removeFriend(Friend friend) async {
    Database db = await dbCreateService.initializeDB();
    await db.delete(
      FriendSchema.tableName,
      where: '${FriendSchema.idFriendCol} = ?',
      whereArgs: [friend.idFriend],
    );
  }

  @override
  Future<void> addFriendWhenNotExists(Friend friend) async {
    Database db = await dbCreateService.initializeDB();
    List<Friend> friends = await getFriends();
    if (!friends.contains(friend)) {
      await db.insert(FriendSchema.tableName, friend.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

}
