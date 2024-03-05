import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SavedAuthData{
  static String _KEY_ACCESS_TOKKEN = "access_token";
  static String _KEY_REFRESH_TOKEN = "refresh_token";
  static String _EMAIL = "email";
  static String _PASSWORD = "password";

   void saveAccessToken(String accessToken) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _KEY_ACCESS_TOKKEN, value: accessToken);
  }

    Future<String?> getAccessToken()  {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return  storage.read(key: _KEY_ACCESS_TOKKEN);
   // return Future(() => null);
  }

   Future<void> deleteAccessToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _KEY_ACCESS_TOKKEN);
  }

   void saveRefreshToken(String refreshToken) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _KEY_REFRESH_TOKEN, value: refreshToken);
  }

   Future<String?> getRefreshToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _KEY_REFRESH_TOKEN);
  }

  Future<void> deleteRefreshToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _KEY_REFRESH_TOKEN);
  }

   void saveEmail(String email) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _EMAIL, value: email);
  }

   Future<String?> getEmail() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _EMAIL);
  }

   void deleteEmail() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _EMAIL);
  }

   void savePassword(String password) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _PASSWORD, value: password);
  }

   Future<String?> getPassword() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _PASSWORD);
  }

   void deletePassword() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _PASSWORD);
  }

   void deleteAllTokens() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
  }

}
