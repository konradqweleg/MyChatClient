import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/database/db_services/friends/friends_service.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/user_data.dart';
import 'package:my_chat_client/main_conversations_list/add_friend/request_find_user_matching_pattern.dart';

import '../../database/db_services/info_about_me/info_about_me_service.dart';
import '../../database/model/friend.dart';
import '../../login_and_registration/common/result.dart';
import 'person_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() {
    return FindUsersView();
  }
}

class FindUsersView extends State<AddFriendView> {

  final GetIt _getIt = GetIt.instance;
  List<PersonView> _matchUsersViewElement = [];
  String actualPatternInSearchTextBox = "";


  void _clearList() {
    setState(() {
      _matchUsersViewElement = [];
    });
  }

  Future<List<UserData>> _filterUserWithAlreadyFriends(List<UserData> users) async {
    List<Friend> friends = await _getIt<FriendsService>().getFriends();
    int idUser = await _getIt<InfoAboutMeService>().getId();

    users.removeWhere((element) => friends.any((element2) => element.id == element2.idFriend));

    users.removeWhere((element) => element.id == idUser);

    return users;
  }



  List<UserData> _convertJsonToUserDataList(String json) {
    var usersRawData = jsonDecode(json) as List;
    List<UserData> users = usersRawData.map((tagJson) => UserData.fromJson(tagJson)).toList();
    return users;
  }

  Future<List<UserData>> _download(String pattern) async {
    Result usersMatchPattern = await _getIt<RequestFindUserMatchingPattern>().requestFindUserMatchingPattern(pattern);
    if (usersMatchPattern.isError()) {
      return [];
    }
    List<UserData> users = _convertJsonToUserDataList(usersMatchPattern.data);
    return users;
  }


  List<PersonView> _convertUserDataToElemAddFriendList(List<UserData> users) {
    return users.map((e) => PersonView(e.name!, e.surname!, e.id!, ()  {
       _downloadUsersMatchToPatternInSearchField(actualPatternInSearchTextBox);
    })).toList();
  }


  Future<void> _downloadUsersMatchToPatternInSearchField(String pattern) async {
    if (pattern.isEmpty) {
      _clearList();
      return;
    }

    List<UserData> users = await _download(pattern);
    if(users.isEmpty) {
      return;
    }

    users = await _filterUserWithAlreadyFriends(users);

    setState(() {
      _matchUsersViewElement = _convertUserDataToElemAddFriendList(users);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
        title: SizedBox(
            width: MediaQuery.of(context).size.width - 80,
            child: TextField(
                onChanged: (text) {
                  actualPatternInSearchTextBox = text;
                  _downloadUsersMatchToPatternInSearchField(text);
                },
                style: const TextStyle(fontSize: 16.0),
                decoration:  InputDecoration(
                  labelText: AppLocalizations.of(context)!.search,
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                ))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //  PageRouteNavigation.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child:  Text(
                    AppLocalizations.of(context)!.people,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: _matchUsersViewElement,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
