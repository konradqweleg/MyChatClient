import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service.dart';
import 'package:my_chat_client/database/db_services/messages/messages_service_sqlite.dart';
import 'package:my_chat_client/database/model/message.dart';

import '../../ui/mock/di/di_utils.dart';
import '../db_utils/db_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Messages service database tests', () {
    setUp(() async {
      DiUtils.registerDefaultDi();
      DbUtils dbUtils = DbUtils();
      await dbUtils.cleanAllDataInDatabase();
    });

    testWidgets('Operation add message should add message to database',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();
      Message messageToSave = Message(
          idMessage: 1,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);

      //when
      await messagesService.addMessage(messageToSave);

      //then
      List<Message> messagesFromDb = await messagesService.getMessages();

      expect(messagesFromDb.length, 1);
      expect(messagesFromDb[0].idMessage, messageToSave.idMessage);
      expect(messagesFromDb[0].message, messageToSave.message);
      expect(messagesFromDb[0].idSender, messageToSave.idSender);
      expect(messagesFromDb[0].idReceiver, messageToSave.idReceiver);
      expect(messagesFromDb[0].date, messageToSave.date);
    });

    testWidgets(
        'Operation get messages should return all messages from database',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();

      for (int i = 0; i < 10; i++) {
        Message messageToSave = Message(
            idMessage: i,
            message: 'Hello',
            date: DateTime.now().toString(),
            idSender: 1,
            idReceiver: 2);
        await messagesService.addMessage(messageToSave);
      }

      //when
      List<Message> messagesFromDb = await messagesService.getMessages();

      //then
      expect(10, messagesFromDb.length);
      for (int i = 0; i < 10; i++) {
        expect(messagesFromDb[i].idMessage, i);
        expect(messagesFromDb[i].message, 'Hello');
        expect(messagesFromDb[i].idSender, 1);
        expect(messagesFromDb[i].idReceiver, 2);
      }
    });

    testWidgets(
        'Operation get messages with friend with specific id should return  messages with specific friend',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();
      int idActualUser = 1;
      int idFirstFriend = 2;
      int idSecondFriend = 3;

      Message firstMessageWithFirstFriend = Message(
          idMessage: 1,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: idActualUser,
          idReceiver: idFirstFriend);

      Message secondMessageWithFirstFriend = Message(
          idMessage: 2,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: idFirstFriend,
          idReceiver: idActualUser);

      Message firstMessageWithSecondFriend = Message(
          idMessage: 3,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: idActualUser,
          idReceiver: idSecondFriend);

      await messagesService.addMessage(firstMessageWithFirstFriend);
      await messagesService.addMessage(secondMessageWithFirstFriend);
      await messagesService.addMessage(firstMessageWithSecondFriend);

      //when
      List<Message> messagesWithFirstFriend =
          await messagesService.getMessagesWithFriendId(idFirstFriend);

      //then
      expect(messagesWithFirstFriend.length, 2);

      expect(messagesWithFirstFriend[0].idMessage,
          firstMessageWithFirstFriend.idMessage);
      expect(messagesWithFirstFriend[0].message,
          firstMessageWithFirstFriend.message);
      expect(messagesWithFirstFriend[0].idSender,
          firstMessageWithFirstFriend.idSender);
      expect(messagesWithFirstFriend[0].idReceiver,
          firstMessageWithFirstFriend.idReceiver);
      expect(messagesWithFirstFriend[0].date, firstMessageWithFirstFriend.date);

      expect(messagesWithFirstFriend[1].idMessage,
          secondMessageWithFirstFriend.idMessage);
      expect(messagesWithFirstFriend[1].message,
          secondMessageWithFirstFriend.message);
      expect(messagesWithFirstFriend[1].idSender,
          secondMessageWithFirstFriend.idSender);
      expect(messagesWithFirstFriend[1].idReceiver,
          secondMessageWithFirstFriend.idReceiver);
      expect(
          messagesWithFirstFriend[1].date, secondMessageWithFirstFriend.date);
    });

    testWidgets('Operation remove message should remove message from database',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();
      Message messageToSave = Message(
          idMessage: 1,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);
      await messagesService.addMessage(messageToSave);

      //when
      await messagesService.removeMessage(messageToSave);

      //then
      List<Message> messagesFromDb = await messagesService.getMessages();
      expect(messagesFromDb.length, 0);
    });

    testWidgets('Operation update message should update message in database',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();
      Message messageToSave = Message(
          idMessage: 1,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);
      await messagesService.addMessage(messageToSave);

      //when
      Message messageToUpdate = Message(
          idMessage: 1,
          message: 'Hello updated',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);
      await messagesService.updateMessage(messageToUpdate);

      //then
      List<Message> messagesFromDb = await messagesService.getMessages();
      expect(messagesFromDb.length, 1);
      expect(messagesFromDb[0].idMessage, messageToUpdate.idMessage);
      expect(messagesFromDb[0].message, messageToUpdate.message);
      expect(messagesFromDb[0].idSender, messageToUpdate.idSender);
      expect(messagesFromDb[0].idReceiver, messageToUpdate.idReceiver);
      expect(messagesFromDb[0].date, messageToUpdate.date);
    });

    testWidgets(
        'Operation last message with friend should return last message with friend',
        (WidgetTester tester) async {
      //given
      MessagesService messagesService = MessagesServiceSqLite();

      Message firstMessageWithFriend = Message(
          idMessage: 1,
          message: 'Hello',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);

      Message secondMessageWithFriend = Message(
          idMessage: 2,
          message: 'Hello Second',
          date: DateTime.now().toString(),
          idSender: 1,
          idReceiver: 2);

      await messagesService.addMessage(firstMessageWithFriend);
      await messagesService.addMessage(secondMessageWithFriend);

      //when
      Message? lastMessageWithFriend =
          await messagesService.getLastMessageWithFriendId(2);

      //then
      expect(
          lastMessageWithFriend!.idMessage, secondMessageWithFriend.idMessage);
      expect(lastMessageWithFriend.message, secondMessageWithFriend.message);
      expect(lastMessageWithFriend.idSender, secondMessageWithFriend.idSender);
      expect(
          lastMessageWithFriend.idReceiver, secondMessageWithFriend.idReceiver);
      expect(lastMessageWithFriend.date, secondMessageWithFriend.date);
    });
  });
}
