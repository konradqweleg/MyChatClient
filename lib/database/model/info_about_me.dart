class InfoAboutMe {
  final int id;
  final String name;
  final String surname;
  final String email;

  InfoAboutMe({required this.id, required this.name, required this.surname, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
    };
  }

  factory InfoAboutMe.fromMap(Map<String, dynamic> map) {
    return InfoAboutMe(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      email: map['email'],
    );
  }
}