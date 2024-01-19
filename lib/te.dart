import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_client/style/main_style.dart';

import 'http/http_helper_auth.dart';
import 'login_and_registration/common/result.dart';
import 'login_and_registration/login/data/auth_data.dart';

Future<void> main() async {

  runApp(
      const App()
  );

  AuthData.saveAccessToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiVVNFUiIsImlzcyI6IlNPTUVfTkFNRV9GT1JfSVNTRVJfSldUIiwidHlwZVRva2VuIjoiQUNDRVNTX1RPS0VOIiwidXNlckVtYWlsIjoiYWRtaW5AYWRtaW4ucGwiLCJleHAiOjE3MDU2OTgxNjV9.LgMglJpDlOIqARPuaIMbMYWOVMmEItMCEs8-oy6Fq8s");

  Result a =   await HttpHelperAuth.executeHttpWithAccessTokenRequestWithTimeout("http://127.0.0.1:8083/xd/xd", "body");
  print(a);


  //  await  HttpHelperAuth.executeHttpWithAccessTokenRequestWithTimeout("http://127.0.0.1:8083/xd/xd", "body") ;
  // result.then((value) => print(value)).onError((error, stackTrace) => {print(error)});


}


class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MY CHAT",

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MainAppStyle.mainColorApp),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Text("text")),
    );
  }

}