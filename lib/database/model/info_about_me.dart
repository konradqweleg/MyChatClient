class InfoAboutMe {
  final int id;
  final String name;
  final String surname;

  InfoAboutMe({required this.id, required this.name, required this.surname});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
    };
  }

  factory InfoAboutMe.fromMap(Map<String, dynamic> map) {
    return InfoAboutMe(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
    );
  }
}