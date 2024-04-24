class RequestsURL{
  //static String register = "http://10.0.2.2:8083/api/v1/user/register";
  // static String register = "http://10.0.2.2:8083/api/v1/user/register";
  //static String resendActiveAccountCode = "http://10.0.2.2:8083/api/v1/user/resendActiveUserAccountCode";
  // static String login = "http://10.0.2.2:8083/api/v1/user/checkIsUserWithThisEmailExist";
  //static String checkIsCorrectResetPasswordCode = "http://10.0.2.2:8083/api/v1/user/checkIsCorrectResetPasswordCode";

 // static String ipAddress = "127.0.0.1";
  //static String ipAddress = "10.0.2.2";
  static String ipAddress = "192.168.1.6";


  static String register = "http://$ipAddress:8083/api/v1/user/register";
  static String confirmCodeCreateAccount = "http://$ipAddress:8083/api/v1/user/activeUserAccount";
  static String resendActiveAccountCode = "http://$ipAddress:8083/api/v1/user/resendActiveUserAccountCode";
  static String checkIsUserWithThisEmailExist = "http://$ipAddress:8083/api/v1/user/checkIsUserWithThisEmailExist";
  static String sendResetPasswordCode = "http://$ipAddress/api/v1/user/sendResetPasswordCode";
  static String checkIsCorrectResetPasswordCode = "http://$ipAddress:8083/api/v1/user/checkIsCorrectResetPasswordCode";
  static String changePassword = "http://$ipAddress:8083/api/v1/user/changeUserPassword";
  static String login = "http://$ipAddress:8083/api/v1/auth/login";
  static String refreshToken = "http://$ipAddress:8083/api/v1/auth/refreshAccessToken";
  static String getLastMessagesWithFriends = "http://$ipAddress:8083/api/v1/message/getLastMessageWithAllFriendsUser?idUser=";
  static String isValidTokens = "http://$ipAddress:8083/api/v1/auth/isCorrectAccessToken";
  static String getUserDataByEmail = "http://$ipAddress:8083/api/v1/user/getUserAboutEmail?email=";
  static String getUserFriends = "http://$ipAddress:8083/api/v1/friends/getUserFriends?idUser=";
  static String postSendMessage= "http://$ipAddress:8083/api/v1/message/insertMessage";
  static String getMessagesWithFriend = "http://$ipAddress:8083/api/v1/message/getMessageBetweenUsers?idFirstUser=";
  static String findUserMatchingPattern = "http://$ipAddress:8083/api/v1/user/getUsersMatchingNameSurname?patternName=";
  static String addFriend = "http://$ipAddress:8083/api/v1/friends/createFriends";


}