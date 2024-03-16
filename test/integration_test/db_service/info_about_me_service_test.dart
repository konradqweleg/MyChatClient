import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service_sqlite.dart';
import 'package:my_chat_client/database/model/info_about_me.dart';

import '../../ui/mock/di/di_utils.dart';
import '../db_utils/db_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Info about me database service tests', () {
    setUp(() async {
      DiUtils.registerDefaultDi();
      DbUtils dbUtils = DbUtils();
      await dbUtils.cleanAllDataInDatabase();
    });



    testWidgets('Operation update info about me should update info about me',
        (WidgetTester tester) async {
      //given
      InfoAboutMeService infoAboutMeService = InfoAboutMeServiceSqlite();
      InfoAboutMe infoAboutMeToUpdate = InfoAboutMe(
          id: 1, name: 'John', surname: 'Doe', email: 'email@example.com');

      //when
      await infoAboutMeService.updateAllInfoAboutMe(infoAboutMeToUpdate);

      //then
      String name = await infoAboutMeService.getName();
      String surname = await infoAboutMeService.getSurname();
      int id = await infoAboutMeService.getId();
      String email = await infoAboutMeService.getEmail();
      bool isInfoAboutMeExist = await infoAboutMeService.isInfoAboutMeExist();

      expect(name, infoAboutMeToUpdate.name);
      expect(surname, infoAboutMeToUpdate.surname);
      expect(id, infoAboutMeToUpdate.id);
      expect(email, infoAboutMeToUpdate.email);
      expect(true, isInfoAboutMeExist);
    });

    testWidgets(
        'The repeated operation of setting user information should overwrite the previous one',
        (WidgetTester tester) async {
      //given
      InfoAboutMeService infoAboutMeService = InfoAboutMeServiceSqlite();
      InfoAboutMe infoAboutMeToUpdate = InfoAboutMe(
          id: 1, name: 'John', surname: 'Doe', email: 'email@example.com');
      InfoAboutMe infoAboutMeToUpdateSecond = InfoAboutMe(
          id: 2, name: 'John2', surname: 'Doe2', email: 'email2@example.com');

      //when
      await infoAboutMeService.updateAllInfoAboutMe(infoAboutMeToUpdate);
      await infoAboutMeService.updateAllInfoAboutMe(infoAboutMeToUpdateSecond);

      //then
      String name = await infoAboutMeService.getName();
      String surname = await infoAboutMeService.getSurname();
      int id = await infoAboutMeService.getId();
      String email = await infoAboutMeService.getEmail();
      bool isInfoAboutMeExist = await infoAboutMeService.isInfoAboutMeExist();

      expect(name, infoAboutMeToUpdateSecond.name);
      expect(surname, infoAboutMeToUpdateSecond.surname);
      expect(id, infoAboutMeToUpdateSecond.id);
      expect(email, infoAboutMeToUpdateSecond.email);
      expect(true, isInfoAboutMeExist);
    });

    testWidgets(
        'When there is no saved user data, the operation to check if user data is saved should return no',
        (WidgetTester tester) async {
      //given
      InfoAboutMeService infoAboutMeService = InfoAboutMeServiceSqlite();
      InfoAboutMe infoAboutMeToUpdate = InfoAboutMe(
          id: 1, name: 'John', surname: 'Doe', email: 'email@example.com');
      await infoAboutMeService.updateAllInfoAboutMe(infoAboutMeToUpdate);

      //when
      bool isInfoAboutMeExist = await infoAboutMeService.isInfoAboutMeExist();

      //then
      expect(true, isInfoAboutMeExist);
    });

    testWidgets(
        'When there is  saved user data, the operation to check if user data is saved should return yes',
        (WidgetTester tester) async {
      //given
      InfoAboutMeService infoAboutMeService = InfoAboutMeServiceSqlite();

      //when
      bool isInfoAboutMeExist = await infoAboutMeService.isInfoAboutMeExist();

      //then
      expect(false, isInfoAboutMeExist);
    });
  });
}
