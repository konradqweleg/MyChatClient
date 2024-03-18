import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/database/db_services/info_about_me/info_about_me_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/database/model/friend.dart';
import 'package:my_chat_client/database/model/info_about_me.dart';
import 'package:my_chat_client/database/model/message.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/main_conversations_list/list_friends/list_conversations.dart';
import 'package:my_chat_client/main_conversations_list/requests/request_last_message.dart';

import '../../ui/confirm_register_code/confirm_code_register_test.dart';
import '../../ui/mock/di/di_utils.dart';
import '../db_utils/db_utils.dart';

GetIt getIt = GetIt.instance;

class MockRequestGetLastMessageReturnCorrectMessage extends RequestLastMessage {
  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) {
    return Future.value(Result.success("""[
        {
        "idFriend": 2,
        "idSender": 2,
        "idReceiver": 1,
        "idMessage": 3,
        "name": "John",
        "surname": "Walker",
        "message": "Message First",
        "dateTimeMessage": "2024-03-09T20:42:53.492+00:00"
        },
        {
        "idFriend": 3,
        "idSender": 3,
        "idReceiver": 1,
        "idMessage": 6,
        "name": "Adam",
        "surname": "Czajka",
        "message": "Message Second",
        "dateTimeMessage": "2024-03-09T20:43:01.764+00:00"
        },
        {
        "idFriend": 4,
        "idSender": 4,
        "idReceiver": 1,
        "idMessage": 8,
        "name": "Wojtek",
        "surname": "Szymanek",
        "message": "Message Third",
        "dateTimeMessage": "2024-03-09T20:43:07.247+00:00"
        }]"""));
  }
}

class MockRequestGetLastMessageReturnVeryLongOneMessage
    extends RequestLastMessage {
  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) {
    return Future.value(Result.success("""[
        {
        "idFriend": 2,
        "idSender": 2,
        "idReceiver": 1,
        "idMessage": 3,
        "name": "John",
        "surname": "Walker",
        "message": "Lorem ipsum dolor sit amet, consectetur adipiscing test lorem ipsum",
        "dateTimeMessage": "2024-03-09T20:42:53.492+00:00"
        }
       ]"""));
  }
}

class MockRequestGetLastMessageReturnDifferentResponseFirstAndSecondCall
    extends RequestLastMessage {
  static int _numberOfCall = 0;

  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) {
    _numberOfCall++;
    if (_numberOfCall == 1) {
      return Future.value(Result.success("""[
        {
        "idFriend": 2,
        "idSender": 2,
        "idReceiver": 1,
        "idMessage": 3,
        "name": "John",
        "surname": "Walker",
        "message": "Message First",
        "dateTimeMessage": "2024-03-09T20:42:53.492+00:00"
        }
       ]"""));
    } else {
      return Future.value(Result.success("""[
        {
        "idFriend": 2,
        "idSender": 2,
        "idReceiver": 1,
        "idMessage": 3,
        "name": "John",
        "surname": "Walker",
        "message": "Message Second",
        "dateTimeMessage": "2024-03-09T20:42:53.492+00:00"
        },
        {
        "idFriend": 3,
        "idSender": 3,
        "idReceiver": 1,
        "idMessage": 6,
        "name": "Adam",
        "surname": "Czajka",
        "message": "Message Third",
        "dateTimeMessage": "2024-03-09T20:43:01.764+00:00"
        }
       ]"""));
    }
  }
}

class MockRequestGetLastMessageReturnError extends RequestLastMessage {
  @override
  Future<Result> getLastMessagesWithFriendsForUserAboutId(int idUser) {
    return Future.value(Result.error("Error"));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await DiUtils.registerDefaultDi();
    DbUtils dbUtils = DbUtils();
    await dbUtils.cleanAllDataInDatabase();
  });

  group('List conversations tests', () {
    testWidgets("Should show list conversations with friends", (tester) async {
      //given
      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'Joe', surname: 'Doe', email: 'example@mail.pl'));
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnCorrectMessage());
      //when
      await Utils.showView(
          tester,
          ListConversations(
            refreshTime: const Duration(minutes: 1),
          ));

      //then
      expect(find.text("John Walker"), findsOneWidget);
      expect(find.text("Message First"), findsOneWidget);

      expect(find.text("Adam Czajka"), findsOneWidget);
      expect(find.text("Message Second"), findsOneWidget);

      expect(find.text("Wojtek Szymanek"), findsOneWidget);
      expect(find.text("Message Third"), findsOneWidget);
    });

    testWidgets(
        "All friends and messages return by request should be added to local database",
        (tester) async {
      //given
      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'Joe', surname: 'Doe', email: 'example@mail.pl'));
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnCorrectMessage());
      await Utils.showView(
          tester,
          ListConversations(
            refreshTime: const Duration(minutes: 1),
          ));

      //when
      List<Friend> friends = await getIt<FriendsService>().getFriends();
      List<Message> messages = await getIt<MessagesService>().getMessages();

      //then
      expect(friends.length, 3);
      expect(messages.length, 3);

      expect(friends[0].name, "John");
      expect(friends[0].surname, "Walker");
      expect(friends[0].idFriend, 2);

      expect(friends[1].name, "Adam");
      expect(friends[1].surname, "Czajka");
      expect(friends[1].idFriend, 3);

      expect(friends[2].name, "Wojtek");
      expect(friends[2].surname, "Szymanek");
      expect(friends[2].idFriend, 4);
    });

    testWidgets(
        "The last messages from friends that are over 50 characters should be trimmed to 50 characters.",
        (tester) async {
      //given
      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'Joe', surname: 'Doe', email: 'example@mail.pl'));
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnVeryLongOneMessage());

      //when
      await Utils.showView(
          tester,
          ListConversations(
            refreshTime: const Duration(minutes: 1),
          ));

      //then
      expect(find.text("Lorem ipsum dolor sit amet, consectetur adipiscing..."),
          findsOneWidget);
    });

    testWidgets(
        "Should not show list conversations with friends when request return error and not caused errors in view",
        (tester) async {
      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'Joe', surname: 'Doe', email: 'example@mail.pl'));
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnError());

      //when
      await Utils.showView(
          tester,
          ListConversations(
            refreshTime: const Duration(minutes: 1),
          ));

      //then
      // NO EXPECTED ERRORS
    });

    testWidgets(
        "When the second call to the request for the latest messages from friends returns different data, the view should be updated.",
        (widgetTester) async {
      //given
      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'Joe', surname: 'Doe', email: 'example@mail.pl'));
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnDifferentResponseFirstAndSecondCall());

      await Utils.showView(
          widgetTester,
          ListConversations(
            refreshTime: const Duration(milliseconds: 500),
          ));

      expect(find.text("John Walker"), findsOneWidget);
      expect(find.text("Message First"), findsOneWidget);

      expect(find.text("Adam Czajka"), findsNothing);
      expect(find.text("Message Second"), findsNothing);
      expect(find.text("Message Third"), findsNothing);

      //when
      await widgetTester.pump(const Duration(milliseconds: 500));

      // then
      expect(find.text("Adam Czajka"), findsOneWidget);
      expect(find.text("Message Third"), findsOneWidget);
      expect(find.text("John Walker"), findsOneWidget);
      expect(find.text("Message Second"), findsOneWidget);
      expect(find.text("Message First"), findsNothing);
    });

    testWidgets(
        "When the request returns an error, the view should be statically loaded from the database of saved messages.",
        (widgetTester) async {
      //given
      DiUtils.get().registerSingleton<RequestLastMessage>(
          MockRequestGetLastMessageReturnError());

      await getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(
          id: 1, name: 'John', surname: 'Doe', email: 'example@mail.pl'));

      await getIt<FriendsService>()
          .addFriend(Friend(idFriend: 2, name: "John", surname: "Walker"));
      await getIt<FriendsService>()
          .addFriend(Friend(idFriend: 3, name: "Adam", surname: "Czajka"));

      await getIt<MessagesService>().addMessage(Message(
          idMessage: 1,
          message: 'Message First',
          idSender: 1,
          idReceiver: 3,
          date: ''));

      await getIt<MessagesService>().addMessage(Message(
          idMessage: 2,
          message: 'Message Second',
          idSender: 1,
          idReceiver: 2,
          date: ''));

      //when
      await Utils.showView(
          widgetTester,
          ListConversations(
            refreshTime: const Duration(minutes: 1),
          ));

      //then
      expect(find.text("John Walker"), findsOneWidget);
      expect(find.text("Message First"), findsOneWidget);

      expect(find.text("Adam Czajka"), findsOneWidget);
      expect(find.text("Message Second"), findsOneWidget);
    });
  });
}
