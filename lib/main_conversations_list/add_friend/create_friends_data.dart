class CreateFriendsData{
  int idFirstFriend;
  int idSecondFriend;

  CreateFriendsData(this.idFirstFriend, this.idSecondFriend);

  Map<String, dynamic> toJson() => {
    'idFirstFriend': idFirstFriend,
    'idSecondFriend': idSecondFriend
  };

  CreateFriendsData.fromJson(Map<String, dynamic> json)
      : idFirstFriend = json['idFirstUser'],
        idSecondFriend = json['idSecondUser'];

}