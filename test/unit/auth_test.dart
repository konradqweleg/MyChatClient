
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/http/http_helper_auth.dart';
import 'package:my_chat_client/login_and_registration/common/result.dart';
import 'package:my_chat_client/login_and_registration/login/data/auth_data.dart';
import 'package:my_chat_client/style/main_style.dart';

Future<void> main() async {

  runApp(
      const App()
  );
  Future<String?> accessToken = AuthData.getAccessToken();
  accessToken.then((value) => {
    print("2.")
  },
      onError: (error) {
        print("Wystąpił błąd: $error");
      }
  );


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