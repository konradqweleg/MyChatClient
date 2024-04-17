class MessageData{
  final int idFriend;
  final int idSender;
  final int idReceiver;
  final String message;
  final int idMessage;
  final int dateTimeMessage;


  MessageData(
      {required this.idFriend,
      required this.idSender,
      required this.idReceiver,
      required this.message,
      required this.idMessage,
      required this.dateTimeMessage});

  MessageData.fromMap(Map item):
    idFriend = item["idFriend"],
    idSender = item["idSender"],
    idReceiver = item["idReceiver"],
    message = item["message"],
    idMessage = item["idMessage"],
    dateTimeMessage = item["dateTimeMessage"];

  Map<String, Object> toMap() {
    return {
      'idFriend': idFriend,
      'idSender': idSender,
      'idReceiver': idReceiver,
      'message': message,
      'idMessage': idMessage,
      'dateTimeMessage': dateTimeMessage
    };
  }
}