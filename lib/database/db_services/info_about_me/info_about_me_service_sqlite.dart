import 'package:my_chat_client/database/schema/info_about_me_schema.dart';
import 'package:sqflite/sqflite.dart';

import '../../create_db/db_create_service.dart';
import '../../model/info_about_me.dart';
import 'info_about_me_service.dart';

class InfoAboutMeServiceSqlite implements InfoAboutMeService{
  DbCreateService dbCreateService = DbCreateService();

  // InfoAboutMeServiceSqlite() {
  //  insertFirstInfoAboutMe();
  // }
  //
  @override
  Future<void> insertFirstInfoAboutMe(InfoAboutMe infoAboutMe) async {
    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      if (maps.isEmpty) {
        return dbCreateService.initializeDB().then((db) {
          return db.insert(InfoAboutMeSchema.tableName, infoAboutMe.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
        });
      } else {
        // Zaktualizuj istniejący rekord
        final Map<String, dynamic> updateValues = infoAboutMe.toMap();
        return dbCreateService.initializeDB().then((db) {
          return db.update(
            InfoAboutMeSchema.tableName,
            updateValues,
            where: "${InfoAboutMeSchema.idCol} = ?",
            whereArgs: [1], // Identyfikator wiersza do aktualizacji (zakładając, że istnieje tylko jeden wiersz w tabeli)
          );
        });
      }
    });
  }
  //
  //
  // }

  @override
  Future<int> getId() async {
    return dbCreateService.initializeDB().then((db) {
      return db.query(InfoAboutMeSchema.tableName);
    }).then((List<Map<String, dynamic>> maps) {
      return maps[0][InfoAboutMeSchema.idCol];
    });
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
  Future<void> setId(int id) async{
    Database db = await dbCreateService.initializeDB();
    await db.update(
      InfoAboutMeSchema.tableName,
      {InfoAboutMeSchema.idCol: id},
    );

  }

  @override
  Future<void> setName(String name) async {
    Database db = await dbCreateService.initializeDB();
    await db.update(
      InfoAboutMeSchema.tableName,
      {InfoAboutMeSchema.nameCol: name},
    );
  }

  @override
  Future<void> setSurname(String surname) async {
    Database db = await dbCreateService.initializeDB();
    await db.update(
      InfoAboutMeSchema.tableName,
      {InfoAboutMeSchema.surnameCol: surname},
    );
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