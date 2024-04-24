import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/main_conversations_list/add_friend/request_add_friend.dart';

import '../../conversation/conversation.dart';
import '../../database/db_services/friends/friends_service.dart';
import '../../database/db_services/info_about_me/info_about_me_service.dart';
import '../../database/model/friend.dart';
import '../../http/request_response_general/status.dart';
import '../../login_and_registration/common/result.dart';
import '../../navigation/page_route_navigation.dart';
import '../requests/friend_data.dart';
import '../requests/request_get_user_friends.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonView extends StatefulWidget {
  final String _personName;
  final String _personSurname;
  final int _idNewFriend;
  final void Function() _refreshUsersMatchToPattern;

  const PersonView(this._personName, this._personSurname, this._idNewFriend,
      this._refreshUsersMatchToPattern,
      {super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  final GetIt _getIt = GetIt.instance;

  Future<Status> _requestAddFriend(int idNewFriend) async {
    int idUser = await _getIt<InfoAboutMeService>().getId();
    Result resultAddFriend = await _getIt<RequestAddFriend>()
        .requestAddFriend(idUser, widget._idNewFriend);

    if (resultAddFriend.isError()) {
      return Future(() => Status(false));
    }

    Map parsedResponse = json.decode(resultAddFriend.data);
    Status status = Status.fromJson(parsedResponse);
    return Future(() => status);
  }

  Future<List<FriendData>> _downloadUserFriends() async {
    int idUser = await _getIt<InfoAboutMeService>().getId();
    return _getIt<RequestGetUserFriends>().getUserFriends(idUser).then((value) {
      if (value.isError()) {
        return [];
      }
      var listFriendsRawData = jsonDecode(value.data as String) as List;
      List<FriendData> friends = listFriendsRawData
          .map((tagJson) => FriendData.fromMap(tagJson))
          .toList();
      return friends;
    });
  }

  Future<void> _updateLocalFriendsDatabase() {
    return _downloadUserFriends().then((friends) {
      for (var friend in friends) {
        _getIt<FriendsService>().addFriendWhenNotExists(Friend(
            idFriend: friend.id, name: friend.name, surname: friend.surname));
      }
    });
  }

  Future<void> _addFriend() async {
    Status status = await _requestAddFriend(widget._idNewFriend);

    if (status.correctResponse) {
      await _updateLocalFriendsDatabase();
      widget._refreshUsersMatchToPattern();
    }
  }

  String getInitials(String name) {
    int maxInitialsCharacters = 2;
    List<String> names = name.split(" ");
    String initials = "";

    if (names.length < maxInitialsCharacters) {
      maxInitialsCharacters = names.length;
    }

    for (var i = 0; i < maxInitialsCharacters; i++) {
      initials += names[i][0].toUpperCase();
    }

    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageRouteNavigation.navigation(
            context: context,
            destination: Conversation(idFriend: widget._idNewFriend),
            isClearBackStack: false);
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 15.0),
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
          child: Row(
            children: [
              ColoredCircleWithText(
                color: Colors.blue,
                letters: getInitials(
                    "${widget._personName} ${widget._personSurname}"),
                size: 50,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                width: MediaQuery.of(context).size.width - 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${widget._personName} ${widget._personSurname}",
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: ()  {
                        _addFriend();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.addFriend,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class ColoredCircleWithText extends StatelessWidget {
  final Color color;
  final String letters;
  final double size;

  const ColoredCircleWithText(
      {super.key,
        required this.color,
        required this.letters,
        required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          letters,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
