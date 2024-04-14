import '../../model/message.dart';

abstract class MessagesService {
  Future<void> addMessage(Message message);
  Future<void> removeMessage(Message message);
  Future<List<Message>> getMessages();
  Future<List<Message>> getMessagesWithFriendId(int friendId);
  Future<Message?> getLastMessageWithFriendId(int friendId);
  Future<void> updateMessage(Message message);
}