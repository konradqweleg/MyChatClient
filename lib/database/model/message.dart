class Message{
  final int idMessage;
  final String message;
  final int idSender;
  final int idReceiver;
  String date;

  Message({required this.idMessage, required this.message, required this.idSender, required this.idReceiver, required this.date});

  Message.fromMap(Map<String, dynamic> item):idMessage=item["idMessage"], message= item["message"], idSender= item["idSender"], idReceiver= item["idReceiver"], date= item["date"];

  Map<String, Object> toMap(){
    return {'idMessage':idMessage,'message': message, 'idSender': idSender, 'idReceiver': idReceiver, 'date': date};
  }
}