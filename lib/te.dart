import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_chat_client/http/http_helper_factory.dart';
import 'package:my_chat_client/style/main_style.dart';
import 'package:my_chat_client/tokens/token_manager.dart';
import 'package:my_chat_client/tokens/token_manager_factory.dart';


import 'http/http_helper_auth.dart';
import 'http/request_refresh_access_token_http.dart';
import 'login_and_registration/common/result.dart';


Future<void> main() async {

  runApp(
      const App()
  );


  // RequestRefreshAccessTokenHttp requestRefreshAccessTokenHttp = RequestRefreshAccessTokenHttp();
  // Result resultRefreshAccessToken = await requestRefreshAccessTokenHttp.refreshAccessToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBhZG1pbi5wbCIsInJvbGUiOiJVU0VSIiwiaXNzIjoiU09NRV9OQU1FX0ZPUl9JU1NFUl9KV1QiLCJ0eXBlVG9rZW4iOiJSRUZSRVNIX1RPS0VOIiwidXNlckVtYWlsIjoiYWRtaW5AYWRtaW4ucGwiLCJleHAiOjE3MDYwNDk2ODB9.AiDpG407u1g048pni1OrpMVu2kd9hENBNLk_eN-8a8U");
  // print(resultRefreshAccessToken.getData());

  TokenManager tokenManager = TokenManagerFactory.getTokenManager();

  tokenManager.saveAccessToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJyb2xlIjoiVVNFUiIsImlzcyI6IlNPTUVfTkFNRV9GT1JfSVNTRVJfSldUIiwidHlwZVRva2VuIjoiQUNDRVNTX1RPS0VOIiwidXNlckVtYWlsIjoiYWRtaW5AYWRtaW4ucGwiLCJleHAiOjE3MDYwNDI5NDN9.0neiq9pxwVryjgrNWq2By2xJZoIQ9U987RKzKFarwH0");
  tokenManager.saveRefreshToken("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBhZG1pbi5wbCIsInJvbGUiOiJVU0VSIiwiaXNzIjoiU09NRV9OQU1FX0ZPUl9JU1NFUl9KV1QiLCJ0eXBlVG9rZW4iOiJSRUZSRVNIX1RPS0VOIiwidXNlckVtYWlsIjoiYWRtaW5AYWRtaW4ucGwiLCJleHAiOjE3MDY2NTMzNzV9.Em3FfEYvQqvDEXgTCuhLROramI0ap-ObLdaKV_B6bm0");
  HttpHelperAuth httpHelperAuth = HttpHelperFactory.createHttpHelperAuth();
  Result a =   await httpHelperAuth.get("http://127.0.0.1:8083/xd/xd");
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