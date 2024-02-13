import 'package:sqflite/sqflite.dart';

import '../../create_db/db_create_service.dart';
import '../../model/message.dart';
import '../../schema/message_schema.dart';
import 'messages_service.dart';

class MessagesServiceSqLite extends MessagesService {
  DbCreateService dbCreateService = DbCreateService();

  @override
  Future<void> addMessage(Message message) {
   return dbCreateService.initializeDB().then((db) {
      db.insert(MessageSchema.tableName, message.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  @override
  Future<List<Message>> getLastMessagesWithEachFriend() {
    return dbCreateService.initializeDB().then((db) {
      return db.rawQuery('''
      SELECT * FROM ${MessageSchema.tableName} 
      WHERE (${MessageSchema.idMessageCol}, ${MessageSchema.idReceiverCol}) 
      IN (SELECT ${MessageSchema.idMessageCol}, ${MessageSchema.idReceiverCol} 
          FROM ${MessageSchema.tableName} 
          GROUP BY ${MessageSchema.idSenderCol}, ${MessageSchema.idReceiverCol}) 
      OR (${MessageSchema.idMessageCol}, ${MessageSchema.idSenderCol}) 
      IN (SELECT ${MessageSchema.idMessageCol}, ${MessageSchema.idSenderCol} 
          FROM ${MessageSchema.tableName} 
          GROUP BY ${MessageSchema.idSenderCol}, ${MessageSchema.idReceiverCol})
      ''');
    }).then((List<Map<String, dynamic>> maps) {
      return List.generate(maps.length, (i) {
        return Message(
          idMessage: maps[i][MessageSchema.idMessageCol],
          message: maps[i][MessageSchema.messageCol],
          date: maps[i][MessageSchema.dateCol],
          idSender: maps[i][MessageSchema.idSenderCol],
          idReceiver: maps[i][MessageSchema.idReceiverCol],
        );
      });
    });
  }

  @override
  Future<List<Message>> getMessages() {
    return dbCreateService.initializeDB().then((db) {
      return db.query(MessageSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return List.generate(maps.length, (i) {
        return Message(
          idMessage: maps[i][MessageSchema.idMessageCol],
          message: maps[i][MessageSchema.messageCol],
          date: maps[i][MessageSchema.dateCol],
          idSender: maps[i][MessageSchema.idSenderCol],
          idReceiver: maps[i][MessageSchema.idReceiverCol],
        );
      });
    });
  }

  @override
  Future<List<Message>> getMessagesWithFriendId(int friendId) {
    return dbCreateService.initializeDB().then((db) {
      return db.query(MessageSchema.tableName, where: '${MessageSchema.idReceiverCol} = ? OR ${MessageSchema.idSenderCol} = ?', whereArgs: [friendId, friendId]);
    }).then((List<Map<String, dynamic>> maps) {
      return List.generate(maps.length, (i) {
        return Message(
          idMessage: maps[i][MessageSchema.idMessageCol],
          message: maps[i][MessageSchema.messageCol],
          date: maps[i][MessageSchema.dateCol],
          idSender: maps[i][MessageSchema.idSenderCol],
          idReceiver: maps[i][MessageSchema.idReceiverCol],
        );
      });
    });
  }

  @override
  Future<void> removeMessage(Message message) {
    return dbCreateService.initializeDB().then((db) {
      db.delete(
        MessageSchema.tableName,
        where: '${MessageSchema.idMessageCol} = ?',
        whereArgs: [message.idMessage],
      );
    });
  }

  @override
  Future<void> updateMessage(Message message) {
    return dbCreateService.initializeDB().then((db) {
      db.update(
        MessageSchema.tableName,
        message.toMap(),
        where: '${MessageSchema.idMessageCol} = ?',
        whereArgs: [message.idMessage],
      );
    });
  }

  @override
  Future<Message> getLastMessageWithFriendId(int friendId) {
    return dbCreateService.initializeDB().then((db) {
      return db.query(MessageSchema.tableName, where: '${MessageSchema.idReceiverCol} = ? OR ${MessageSchema.idSenderCol} = ?', whereArgs: [friendId, friendId]);
    }).then((List<Map<String, dynamic>> maps) {
      return Message(
        idMessage: maps[0][MessageSchema.idMessageCol],
        message: maps[0][MessageSchema.messageCol],
        date: maps[0][MessageSchema.dateCol],
        idSender: maps[0][MessageSchema.idSenderCol],
        idReceiver: maps[0][MessageSchema.idReceiverCol],
      );
    });
  }


}