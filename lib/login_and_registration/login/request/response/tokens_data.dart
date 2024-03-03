class TokensData {
  String accessToken;
  String refreshToken;

  TokensData({required this.accessToken, required this.refreshToken});

  factory TokensData.fromJson(Map json) {
    return TokensData(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}

