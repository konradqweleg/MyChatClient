class AccessTokenData{
  String? _accessToken;
  AccessTokenData({required String accessToken}) : _accessToken = accessToken;

  AccessTokenData.fromJson(Map json){
    _accessToken = json['token'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = _accessToken;
    return data;
  }

  String get accessToken => _accessToken!;
}