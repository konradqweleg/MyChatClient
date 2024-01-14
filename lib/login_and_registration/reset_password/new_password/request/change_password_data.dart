class ChangePasswordData {
  String email;
  String code;
  String password;

  ChangePasswordData({
    required this.email,
    required this.code,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
      'password': password,
    };
  }
}