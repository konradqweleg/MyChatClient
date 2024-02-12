class Friend{
  final int idFriend;
  final String name;
  final String surname;

  Friend({required this.idFriend, required this.name, required this.surname});

  Friend.fromMap(Map<String, dynamic> item):idFriend=item["idFriend"], name= item["name"], surname= item["surname"];

  Map<String, Object> toMap(){
    return {'idFriend':idFriend,'name': name, 'surname': surname};
  }

}