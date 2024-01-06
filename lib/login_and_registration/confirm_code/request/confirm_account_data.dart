class ConfirmAccountData{
  String _email;
  String _code;

  ConfirmAccountData({required String email, required String code}) : _code = code, _email = email;

  String get email => _email;
  String get code => _code;

  Map<String, dynamic> toJson() {
    return {
      'email': _email,
      'code': _code,
    };
  }
}