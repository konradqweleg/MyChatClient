class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({required this.accessToken, required this.refreshToken});

  factory Tokens.fromJson(Map json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}

