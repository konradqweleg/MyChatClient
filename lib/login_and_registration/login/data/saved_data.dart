import 'package:shared_preferences/shared_preferences.dart';

class SavedData{
  static const String _KEY_IS_USER_LOGIN = "loggedIn";


  static  void setUserLoginFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_KEY_IS_USER_LOGIN, true);
  }

 static void deleteUserLoginFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_KEY_IS_USER_LOGIN, false);
  }

 static bool isUserLogin() {
    SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
    return prefs.getBool(_KEY_IS_USER_LOGIN) ?? false;
  }


}