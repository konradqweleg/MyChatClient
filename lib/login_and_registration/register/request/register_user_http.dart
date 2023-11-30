import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_chat_client/login_and_registration/register/request/error_message.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_response.dart';
import 'package:my_chat_client/login_and_registration/register/request/register_user_request.dart';
import 'package:my_chat_client/login_and_registration/register/request/status.dart';
import 'package:my_chat_client/login_and_registration/register/user_register_data.dart';

import '../../../requests/Requests.dart';

class RegisterUserHttp extends RegisterUserRequest{

  @override
    Future<RegisterResponse> register(UserRegisterData userRegisterData) async {
    var urlRequestRegister = Uri.parse(Requests.register);

    var bodyUserRegisterData = jsonEncode(userRegisterData);

    var request = await http.post(
      urlRequestRegister,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyUserRegisterData,
    );

    if (request.statusCode == 200) {
     Map parsedResponse = json.decode(request.body);
     Status status =  Status.fromJson(parsedResponse);

     if(status.correctResponse){
       return RegisterResponse.ok;
     }else{
       return RegisterResponse.error;
     }

    } else {
      print('Treść błędu: ${request.body}');
      Map parsedResponse = json.decode(request.body);
      ErrorMessage error =  ErrorMessage.fromJson(parsedResponse);

      if(error.errorMessage == " User already exist "){
        return RegisterResponse.userAlreadyExists;
      }else{
        return RegisterResponse.error;
      }

      // print('Wystąpił problem podczas wysyłania żądania POST.');
      // print('Status kodu: ${request.statusCode}');
      // print('Treść błędu: ${request.body}');


    }

   // return true;

  }

}