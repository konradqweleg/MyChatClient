class FriendData {
  final int id;
  final String name;
  final String surname;
  final String email;


  FriendData(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email});

  FriendData.fromMap(Map item):
    id = item["id"],
    name = item["name"],
    surname = item["surname"],
    email = item["email"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email
    };
  }

  @override
  String toString() {
    return 'FriendData{id: $id, name: $name, surname: $surname, email: $email}';
  }
}
