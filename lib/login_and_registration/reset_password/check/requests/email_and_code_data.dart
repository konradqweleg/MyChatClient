class EmailAndCodeData {
  final String email;
  final String code;

  EmailAndCodeData({
    required this.email,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}