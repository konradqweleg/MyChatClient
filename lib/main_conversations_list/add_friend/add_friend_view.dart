import 'package:flutter/material.dart';

import '../../navigation/page_route_navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddFriendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Person'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                // Perform the search operation
                // You need to implement the search logic here
                print('Search text: $value');
              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}