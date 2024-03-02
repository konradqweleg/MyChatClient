class LastMessageWithFriendsData{
  final int idUser;
  final int idMessage;
  final String name;
  final String surname;
  final String lastMessage;
  final String date;


  LastMessageWithFriendsData({required this.idUser, required this.idMessage, required this.name, required this.surname, required this.lastMessage, required this.date});

  LastMessageWithFriendsData.fromMap(Map item):idUser=item["idUser"], idMessage=item["idMessage"], name= item["name"], surname= item["surname"], lastMessage= item["message"], date= item["dateTimeMessage"].toString();

  Map<String, Object> toMap(){
    return {'idUser':idUser, 'idMessage':idMessage, 'name': name, 'surname': surname, 'lastMessage': lastMessage, 'date': date};
  }

  @override
  String toString() {
    return 'LastMessageWithFriendsData{idUser: $idUser, idMessage: $idMessage, name: $name, surname: $surname, lastMessage: $lastMessage, date: $date}';
  }

}

