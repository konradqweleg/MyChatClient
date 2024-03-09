class LastMessageWithFriendsData {
  final int idFriend;
  final int idSender;
  final int idReceiver;
  final int idMessage;
  final String name;
  final String surname;
  final String lastMessage;
  final String date;

  LastMessageWithFriendsData(
      {required this.idFriend,
      required this.idSender,
      required this.idReceiver,
      required this.idMessage,
      required this.name,
      required this.surname,
      required this.lastMessage,
      required this.date});

  LastMessageWithFriendsData.fromMap(Map item)
      : idFriend = item["idFriend"],
        idSender = item["idSender"],
        idReceiver = item["idReceiver"],
        idMessage = item["idMessage"],
        name = item["name"],
        surname = item["surname"],
        lastMessage = item["message"],
        date = item["dateTimeMessage"].toString();

  Map<String, Object> toMap() {
    return {
      'idFriend': idFriend,
      'idMessage': idMessage,
      'name': name,
      'surname': surname,
      'lastMessage': lastMessage,
      'date': date
    };
  }

  @override
  String toString() {
    return 'LastMessageWithFriendsData{idFriend: $idFriend, idSender: $idSender, idReceiver: $idReceiver  idMessage: $idMessage, name: $name, surname: $surname, lastMessage: $lastMessage, date: $date}';
  }
}
