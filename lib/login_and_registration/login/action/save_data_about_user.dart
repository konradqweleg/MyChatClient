import 'package:my_chat_client/login_and_registration/login/action/save_data_about_user_status.dart';
import '../../common/result.dart';

abstract class SaveDataAboutUser {
  Future<Result<SaveDataAboutUserStatus>> saveUserData(String userEmail);
}