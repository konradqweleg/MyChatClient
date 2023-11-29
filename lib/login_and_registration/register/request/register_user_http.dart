import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

class RegisterUserHttp extends RegisterUserRequest{

  @override
    Future<bool> register(UserRegisterData userRegisterData) async {
    var url = Uri.parse('https://example.com/api/endpoint'); // Zmień na właściwy adres URL

    var body = json.encode({
      'key1': 'value1',
      'key2': 'value2',
      // Dodaj inne dane do przesłania w żądaniu POST
    });

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Dodaj inne nagłówki według potrzeb
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('Żądanie POST zostało wysłane pomyślnie.');
      print('Odpowiedź: ${response.body}');
    } else {
      print('Wystąpił problem podczas wysyłania żądania POST.');
      print('Status kodu: ${response.statusCode}');
      print('Treść błędu: ${response.body}');
    }

    return true;

  }

}