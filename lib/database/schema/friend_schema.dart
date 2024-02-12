class FriendSchema{
  static const String tableName = 'Friends';

  static const String idFriendCol = "idFriend";
  static const String nameCol = "name";
  static const String surnameCol = "surname";

  static const String createTableQuery = "CREATE TABLE $tableName($idFriendCol INTEGER PRIMARY KEY, $nameCol TEXT NOT NULL, $surnameCol TEXT NOT NULL)";


}