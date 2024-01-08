class EmailData{
  final String _email;
  EmailData({required String email}) :  _email = email;
  String get email => _email;

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
    };
  }
}