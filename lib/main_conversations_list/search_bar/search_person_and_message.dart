import 'package:flutter/material.dart';

class SearchPersonAndMessage extends StatefulWidget {
  const SearchPersonAndMessage({Key? key}) : super(key: key);

  @override
  State<SearchPersonAndMessage> createState() => _SearchPersonAndMessageState();
}

class _SearchPersonAndMessageState extends State<SearchPersonAndMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 10.0,right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20.0,right: 20.0),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text("Search",style: TextStyle(fontSize: 20.0),),
          Icon(Icons.search)
        ],
      )
    );
  }
}