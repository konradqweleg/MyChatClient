
class UserMyChat{
  String name;
  String lastMessage;
  int idUser;

  UserMyChat(this.name, this.lastMessage, this.idUser);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserMyChat &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          lastMessage == other.lastMessage &&
          idUser == other.idUser;

  @override
  int get hashCode => name.hashCode ^ lastMessage.hashCode ^ idUser.hashCode;
}