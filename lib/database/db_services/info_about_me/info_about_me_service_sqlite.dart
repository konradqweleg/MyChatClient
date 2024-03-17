import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:sqflite/sqflite.dart';

import '../../create_db/db_create_service.dart';
import '../../model/info_about_me.dart';
import 'info_about_me_service.dart';

class InfoAboutMeServiceSqlite implements InfoAboutMeService{
  DbCreateService dbCreateService = DbCreateService();

  @override
  Future<void> updateAllInfoAboutMe(InfoAboutMe infoAboutMe) async {

    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      if (maps.isEmpty) {
        _insertInfoAboutMe(infoAboutMe);
      } else {
        _updateInfoAboutMe(infoAboutMe);
      }
    });
  }

  Future<void> _insertInfoAboutMe(InfoAboutMe infoAboutMe) async {
   return  dbCreateService.initializeDB().then((db) {
       db.insert(InfoAboutMeSchema.tableName, infoAboutMe.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<void> _updateInfoAboutMe(InfoAboutMe infoAboutMe) async {
    dbCreateService.initializeDB().then((db) {
      db.update(
        InfoAboutMeSchema.tableName,
        infoAboutMe.toMap(),
        where: "${InfoAboutMeSchema.idCol} = ?",
        whereArgs: [1],
      );
    });
  }


  @override
  Future<int> getId() async {
    Database db = await dbCreateService.initializeDB();
    List<Map<String, dynamic>> maps = await db.query(InfoAboutMeSchema.tableName);
    return maps[0][InfoAboutMeSchema.idCol];
  }

  @override
  Future<String> getName()async {
    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return maps[0][InfoAboutMeSchema.nameCol];
    });

  }

  @override
  Future<String> getSurname() async {
    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return maps[0][InfoAboutMeSchema.surnameCol];
    });
  }


  @override
  Future<String> getEmail() {
    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return maps[0][InfoAboutMeSchema.emailCol];
    });
  }

  @override
  Future<void> setEmail(String email) async {
    Database db = await dbCreateService.initializeDB();
    await db.update(
      InfoAboutMeSchema.tableName,
      {InfoAboutMeSchema.emailCol: email},
    );
  }

  @override
  Future<bool> isInfoAboutMeExist() {
   return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return maps.isNotEmpty;
    });
  }

}