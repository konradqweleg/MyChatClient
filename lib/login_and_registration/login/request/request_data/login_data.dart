class LoginData {
  final String _email;
  final String _password;

  LoginData({required String email, required String password}) : _password = password, _email = email;

  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
      'password': _password,
    };
  }


}