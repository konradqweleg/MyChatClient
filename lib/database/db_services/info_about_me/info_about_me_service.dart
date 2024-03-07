import '../../model/info_about_me.dart';

abstract class InfoAboutMeService{
  Future<void> setName(String name);
  Future<void> setSurname(String surname);
  Future<void> setId(int id);
  Future<void> setEmail(String email);
  Future<String> getName();
  Future<String> getSurname();
  Future<int> getId();
  Future<String> getEmail();
  Future<bool> isInfoAboutMeExist();
  Future<void> insertFirstInfoAboutMe(InfoAboutMe infoAboutMe);


}