class HttpHelperAuth {


  Future<dynamic> executeHttpWithAccessTokenRequestWithTimeout(){

  }

  Future<dynamic> executeHttpWithTryRefreshTokenRequestWithTimeout(){

  }

  void redirectToLoginPage(){

  }

  Future<dynamic> executeHttpRequestWithTimeout(
      String url, {
        Map<String, String>? headers = const <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        dynamic body,
        Duration timeoutDuration = const Duration(seconds: 3),
      }) async {
    try {
      var client = http.Client();
      var response;
      try {
        response = await Future.any([
          client.post(
            Uri.parse(url),
            headers: headers,
            body: body,
          ),
          Future.delayed(timeoutDuration),
        ]);
      } on TimeoutException {
        throw TimeoutException('Request timed out');
      }



      if (response is http.Response) {
        if (response.statusCode == 200 || response.statusCode == 400) {
          return response;
        } else {
          throw Exception('Request failed with status: ${response.statusCode}');
        }
      } else {
        throw Exception('Unknown response');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }
}