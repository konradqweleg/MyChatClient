import 'dart:io';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:my_chat_client/requests/requests_url.dart';

import 'status_code.dart';

class MockHttpClientFactory {

  MockClient withRequestAndResponse(String url, String response,
      int statusCode) {
    return MockClient((request) async {
      if (request.url.toString().startsWith(url)) {
        return Response(response, statusCode,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }
      return throw Exception('failed');
    });
  }



  MockClient withMockReconnectingSuccess () {
    int requestCount = 0;
    int thirdRequestAfterRefreshToken = 3;
    return MockClient((request) async {
      requestCount++;
      if(requestCount == thirdRequestAfterRefreshToken){
        return Response("Correct response", StatusCode.ok, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      if(request.url.toString().startsWith(RequestsURL.refreshToken)){
        return Response("{\"token\":\"tokenData\"}", StatusCode.ok, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      if (request.url.toString().startsWith("https://examplerequest")) {
        return Response("Unauthorized", StatusCode.unauthorized, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      return throw Exception('failed');
    });
  }

  MockClient withMockReconnectingFail () {
    int requestCount = 0;
    int thirdRequestAfterRefreshToken = 3;
    return MockClient((request) async {
      requestCount++;
      if(requestCount == thirdRequestAfterRefreshToken){
        return Response("Unauthorized", StatusCode.unauthorized, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      if(request.url.toString().startsWith(RequestsURL.refreshToken)){
        return Response("Unauthorized", StatusCode.unauthorized, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      if (request.url.toString().startsWith("https://examplerequest")) {
        return Response("Unauthorized", StatusCode.unauthorized, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      }

      return throw Exception('failed');
    });
  }

}