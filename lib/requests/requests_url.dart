class RequestsURL{
  //static String register = "http://10.0.2.2:8083/api/v1/user/register";
  // static String register = "http://10.0.2.2:8083/api/v1/user/register";
  //static String resendActiveAccountCode = "http://10.0.2.2:8083/api/v1/user/resendActiveUserAccountCode";
  // static String login = "http://10.0.2.2:8083/api/v1/user/checkIsUserWithThisEmailExist";
  //static String checkIsCorrectResetPasswordCode = "http://10.0.2.2:8083/api/v1/user/checkIsCorrectResetPasswordCode";


  static String register = "http://127.0.0.1:8083/api/v1/user/register";
  static String confirmCodeCreateAccount = "http://127.0.0.1:8083/api/v1/user/activeUserAccount";
  static String resendActiveAccountCode = "http://127.0.0.1:8083/api/v1/user/resendActiveUserAccountCode";
  static String checkIsUserWithThisEmailExist = "http://127.0.0.1:8083/api/v1/user/checkIsUserWithThisEmailExist";
  static String sendResetPasswordCode = "http://127.0.0.1:8083/api/v1/user/sendResetPasswordCode";
  static String checkIsCorrectResetPasswordCode = "http://127.0.0.1:8083/api/v1/user/checkIsCorrectResetPasswordCode";
  static String changePassword = "http://127.0.0.1:8083/api/v1/user/changeUserPassword";
  static String login = "http://127.0.0.1:8083/api/v1/auth/login";
  static String refreshToken = "http://127.0.0.1:8083/api/v1/auth/refreshAccessToken";
  static String getLastMessagesWithFriends = "http://127.0.0.1:8083/api/v1/message/getLastMessageWithAllFriendsUser?idUser=";


}