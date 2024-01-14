import 'package:my_chat_client/login_and_registration/reset_password/new_password/request/change_password_data.dart';

import '../../../common/result.dart';

abstract class RequestChangePassword{
  Future<Result> requestChangePassword(ChangePasswordData changePasswordData);
}