class UserData{
  int? id;
  String? name;
  String? surname;
  String? email;

  UserData({this.id, this.name, this.surname, this.email});

  factory UserData.fromJson(Map json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
    };
  }



}