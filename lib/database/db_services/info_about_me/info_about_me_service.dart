import '../../model/info_about_me.dart';

abstract class InfoAboutMeService {
  Future<String> getName();

  Future<String> getSurname();

  Future<int> getId();

  Future<String> getEmail();

  Future<bool> isInfoAboutMeExist();

  Future<void> updateAllInfoAboutMe(InfoAboutMe infoAboutMe);
}
