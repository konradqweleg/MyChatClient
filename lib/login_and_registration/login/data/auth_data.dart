import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthData{
  static String _KEY_ACCESS_TOKKEN = "access_token";
  static String _KEY_REFRESH_TOKEN = "refresh_token";
  static String _EMAIL = "email";
  static String _PASSWORD = "password";

  static void saveAccessToken(String accessToken) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _KEY_ACCESS_TOKKEN, value: accessToken);
  }

  static  Future<String?> getAccessToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _KEY_ACCESS_TOKKEN);
  }

  static void deleteAccessToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _KEY_ACCESS_TOKKEN);
  }

  static void saveRefreshToken(String refreshToken) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _KEY_REFRESH_TOKEN, value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _KEY_REFRESH_TOKEN);
  }

  static void deleteRefreshToken() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _KEY_REFRESH_TOKEN);
  }

  static void saveEmail(String email) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _EMAIL, value: email);
  }

  static Future<String?> getEmail() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _EMAIL);
  }

  static void deleteEmail() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _EMAIL);
  }

  static void savePassword(String password) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: _PASSWORD, value: password);
  }

  static Future<String?> getPassword() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: _PASSWORD);
  }

  static void deletePassword() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: _PASSWORD);
  }

  static void deleteAllTokens() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
  }

}
