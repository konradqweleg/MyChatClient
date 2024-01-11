
class ResetPasswordData{
  final String _email;
  ResetPasswordData({required String email}) :  _email = email;
  String get email => _email;

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
    };
  }
}