import 'result.dart';

class ErrorMessage{
  String _errorMessage = "";
  Result? _result;
  ErrorMessage({ String errorMessage = "",required Result result}){
    _errorMessage = errorMessage;
    _result = result;
  }

  factory ErrorMessage.error(String errorMessage,Result result) {
    return ErrorMessage(errorMessage: errorMessage, result: result);
  }

  String getErrorMessage() {
    if (_errorMessage.isEmpty) {
      throw Exception("Error: errorMessage is empty");
    }
    return _errorMessage;
  }

  Result getResult() {
    if (_result == null) {
      throw Exception("Error: result is null");
    }
    return _result!;
  }

}