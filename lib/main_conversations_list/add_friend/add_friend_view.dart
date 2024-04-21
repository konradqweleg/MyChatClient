import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_client/login_and_registration/login/request/response/user_data.dart';
import 'package:my_chat_client/main_conversations_list/add_friend/request_find_user_matching_pattern.dart';

import '../../login_and_registration/common/result.dart';
import 'elem_add_friend_list.dart';
class AddFriendView extends StatefulWidget {




  @override
  State<AddFriendView> createState() {
   return AddFriendViewState();
  }
}

class AddFriendViewState extends State<AddFriendView> {

  List<UserData> usersMatch = [];
  GetIt getIt = GetIt.instance;

  List<ElemAddFriendList> usersMatchWidget = [];

  Future<void> _downloadUserFriends(String pattern) async {

    if(pattern.isEmpty) {
      setState(() {
        usersMatchWidget = [];
      });

      return;
    }

    Result usersMatchPattern = await getIt<RequestFindUserMatchingPattern>().requestFindUserMatchingPattern(pattern);

    if(usersMatchPattern.isError()) {
      return;
    }

    var usersRawData = jsonDecode(usersMatchPattern.data as String) as List;
    List<UserData> users = usersRawData.map((tagJson) => UserData.fromJson(tagJson)).toList();


    setState(() {
      usersMatchWidget = users.map((e) => ElemAddFriendList(e.name!, e.surname!, e.id!)).toList();
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
        title: SizedBox(width: MediaQuery.of(context).size.width-80,child:  TextField(

            onChanged: (text) {
             _downloadUserFriends(text);
            },


            style: TextStyle(fontSize: 16.0),decoration: InputDecoration(
          labelText: 'Search',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
          fillColor: Colors.white, // Set the fill color to white

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
                  child: const Text(
                    "People",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children:
                  usersMatchWidget
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }



}