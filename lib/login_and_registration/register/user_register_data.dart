class UserRegisterData{
  final String email;
  final String password;
  final String name;
  final String surname;

  UserRegisterData(this.email,this.name,this.surname,this.password,);

  Map toJson() => {
    'name': name,
    'surname': surname,
    'email' : email,
    'password' : password
  };


}