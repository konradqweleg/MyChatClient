import 'package:my_chat_client/login_and_registration/common/error_message.dart';

import 'result.dart';

class Errors{
  ErrorMessage? _actualErrorMessage;

  final List<ErrorMessage> _allErrorsMessage = [];

  void registerMatchErrorToResultStatus(ErrorMessage statusMessage){
    _allErrorsMessage.add(statusMessage);
  }

  void setActualError(Result requestResult){
    for (var element in _allErrorsMessage) {
      if(element.getResult() == requestResult){
        _actualErrorMessage = element;
      }
    }
  }

  String getErrorMessage(){
    if(_actualErrorMessage == null){
      throw Exception("Error: _actualErrorMessage is null");
    }
    return _actualErrorMessage!.getErrorMessage();
  }

  bool isInit(){
    return _allErrorsMessage.isEmpty;
  }

  bool isError(){
    return isInit();
  }

}