import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/login_and_registration/login/action/save_data_about_user.dart';
import 'package:my_chat_client/login_and_registration/login/action/save_data_about_user_status.dart';

import '../../../database/db_services/info_about_me/info_about_me_service.dart';
import '../../../database/model/info_about_me.dart';
import '../../common/result.dart';
import '../../confirm_code/request/resend_active_account_code/email_data.dart';
import '../request/get_user_data_request.dart';
import '../request/response/user_data.dart';


class SaveDataAboutUserImpl extends SaveDataAboutUser {
  static final GetIt _getIt = GetIt.instance;

  @override
  Future<Result<SaveDataAboutUserStatus>> saveUserData(String userEmail) async {
    return await _savedDataAboutUser(userEmail);
  }

  Future<void> _savedUserDataInDb(UserData userData) async {
    return _getIt<InfoAboutMeService>().updateAllInfoAboutMe(InfoAboutMe(id: userData.id!, name: userData.name!, surname: userData.surname!, email: userData.email!));
  }

  Future<Result<SaveDataAboutUserStatus>> _savedDataAboutUser(String userEmail)   async {
    bool isAlreadySavedDataAboutUser = await _getIt<InfoAboutMeService>().isInfoAboutMeExist();
    if (!isAlreadySavedDataAboutUser) {
      return await _downloadDataAboutUserFromServerBasedOnEmail(userEmail);
    }else{
      return Result.success(SaveDataAboutUserStatus.success);
    }

  }

  Future<Result<SaveDataAboutUserStatus>> _downloadDataAboutUserFromServerBasedOnEmail(String userEmail) async {
    Result userDataResult = await _getIt<GetUserDataRequest>().getUserDataWithEmail(EmailData(email: userEmail));
    if (userDataResult.isSuccess()) {
      UserData userData = userDataResult.getData();
      await  _savedUserDataInDb(userData);
      return Result.success(SaveDataAboutUserStatus.success);
    } else {
      return Result.error(SaveDataAboutUserStatus.error);
    }
  }


}
