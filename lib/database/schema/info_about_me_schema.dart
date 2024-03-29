class InfoAboutMeSchema{
  static const String tableName = 'infoAboutMe';

  static const String idCol = "id";
  static const String nameCol = "name";
  static const String surnameCol = "surname";
  static const String emailCol = "email";

  static const String createTableQuery = "CREATE TABLE $tableName($idCol INTEGER PRIMARY KEY, $nameCol TEXT NOT NULL, $surnameCol TEXT NOT NULL, $emailCol TEXT NOT NULL)";
  static const String clearAllDataQuery = "DELETE FROM $tableName";
}