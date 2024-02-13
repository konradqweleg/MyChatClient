class MessageSchema{
  static const String idMessageCol = "idMessage";
  static const String messageCol = "message";
  static const String idSenderCol = "idSender";
  static const String idReceiverCol = "idReceiver";
  static const String dateCol = "date";
  static const String tableName = "Messages";


  static const String createTableQuery = "CREATE TABLE Messages(idMessage INTEGER PRIMARY KEY, idSender INTEGER NOT NULL, idReceiver INTEGER NOT NULL, message TEXT NOT NULL, date TEXT NOT NULL)";
}