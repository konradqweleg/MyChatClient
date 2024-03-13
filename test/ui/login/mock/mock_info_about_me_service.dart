import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/model/info_about_me.dart';

class MockInfoAboutMeService implements InfoAboutMeService {
  @override
  Future<String> getEmail() {
    // TODO: implement getEmail
    throw UnimplementedError();
  }

  @override
  Future<int> getId() {
    return Future(() => 1);
  }

  @override
  Future<String> getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }

  @override
  Future<String> getSurname() {
    // TODO: implement getSurname
    throw UnimplementedError();
  }

  @override
  Future<bool> isInfoAboutMeExist() {
    return Future(() => true);
  }

  @override
  Future<void> setEmail(String email) {
    // TODO: implement setEmail
    throw UnimplementedError();
  }

  @override
  Future<void> setId(int id) {
    // TODO: implement setId
    throw UnimplementedError();
  }

  @override
  Future<void> setName(String name) {
    // TODO: implement setName
    throw UnimplementedError();
  }

  @override
  Future<void> setSurname(String surname) {
    // TODO: implement setSurname
    throw UnimplementedError();
  }

  @override
  Future<void> updateAllInfoAboutMe(InfoAboutMe infoAboutMe) {
    // TODO: implement updateAllInfoAboutMe
    throw UnimplementedError();
  }

}