import 'dart:async';
import 'package:http/http.dart' as http;

class HttpHelper {


  final http.Client httpClient;
  HttpHelper(this.httpClient);

  Future<dynamic> executeHttpRequestWithTimeout(
    String url, {
    Map<String, String>? headers = const <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    dynamic body,
    Duration timeoutDuration = const Duration(seconds: 3),
  }) async {
    try {

      var response;
      try {
        response = await Future.any([
          httpClient.post(
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
        if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 401) {
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
