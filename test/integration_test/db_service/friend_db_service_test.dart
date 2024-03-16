import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service_sqlite.dart';
import 'package:my_chat_client/database/model/friend.dart';
import '../db_utils/db_utils.dart';
import '../../ui/mock/di/di_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Friend database service tests', () {
    setUp(() async {
      DiUtils.registerDefaultDi();
      DbUtils dbUtils = DbUtils();
      await dbUtils.cleanAllDataInDatabase();
    });



    testWidgets('Operation add friend should add friend to database',
        (WidgetTester tester) async {
      //given
      FriendsService friendsService = FriendServiceSqlite();
      Friend friendToAdd = Friend(idFriend: 1, name: 'John', surname: 'Doe');

      //when
      await friendsService.addFriend(friendToAdd);

      //then
      List<Friend> friends = await friendsService.getFriends();

      expect(friends.length, 1);
      expect(friends[0].idFriend, friendToAdd.idFriend);
      expect(friends[0].name, friendToAdd.name);
      expect(friends[0].surname, friendToAdd.surname);
    });

    testWidgets('Operation delete friend should delete friend',
        (WidgetTester tester) async {

      //given
      FriendsService friendsService = FriendServiceSqlite();
      Friend friendToAdd = Friend(idFriend: 1, name: 'John', surname: 'Doe');
      await friendsService.addFriend(friendToAdd);

      //when
      await friendsService.removeFriend(friendToAdd);

      //then
      List<Friend> friends = await friendsService.getFriends();
      expect(friends.length, 0);
    });

    testWidgets('Operation add friend when not exists should add friends when this friend not exists in database',
            (WidgetTester tester) async {

          //given
          FriendsService friendsService = FriendServiceSqlite();
          Friend friendToAdd = Friend(idFriend: 1, name: 'John', surname: 'Doe');
          //when
          await friendsService.addFriendWhenNotExists(friendToAdd);

          //then
          List<Friend> friends = await friendsService.getFriends();

          expect(friends.length, 1);
          expect(friends[0].idFriend, friendToAdd.idFriend);
          expect(friends[0].name, friendToAdd.name);
          expect(friends[0].surname,friendToAdd.surname);
        });

    testWidgets('The operation add a user when it does not exist should ignore added the same user twice',
            (WidgetTester tester) async {

          //given
          FriendsService friendsService = FriendServiceSqlite();
          Friend friendToAdd = Friend(idFriend: 1, name: 'John', surname: 'Doe');
          //when
          await friendsService.addFriendWhenNotExists(friendToAdd);
          await friendsService.addFriendWhenNotExists(friendToAdd);

          //then
          List<Friend> friends = await friendsService.getFriends();

          expect(friends.length, 1);
          expect(friends[0].idFriend, friendToAdd.idFriend);
          expect(friends[0].name, friendToAdd.name);
          expect(friends[0].surname, friendToAdd.surname);
        });


    testWidgets('The operation get friends should return all friends',
            (WidgetTester tester) async {

          //given
          FriendsService friendsService = FriendServiceSqlite();
          for(int i=0;i<10;++i){
            Friend friendToAdd = Friend(idFriend: i, name: 'John', surname: 'Doe');
            await friendsService.addFriend(friendToAdd);
          }

          //when
          List<Friend> friends = await friendsService.getFriends();

          //then
          expect(friends.length, 10);
          for(int i=0;i<10;++i){
            expect(friends[i].idFriend, i);
            expect(friends[i].name, 'John');
            expect(friends[i].surname, 'Doe');
          }

        });


  });
}
