class MessageData{
  String message;
  int idUserSender;
  int idUserReceiver;

  MessageData({required this.message, required this.idUserSender, required this.idUserReceiver});

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      message: json['message'],
      idUserSender: json['id_user_sender'],
      idUserReceiver: json['id_user_receiver'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'id_user_sender': idUserSender,
    'id_user_receiver': idUserReceiver,
  };
}