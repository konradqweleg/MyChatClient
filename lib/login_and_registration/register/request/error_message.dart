class ErrorMessage{
  String errorMessage = "";
  ErrorMessage.fromJson(Map json) {
    errorMessage = json['ErrorMessage'];
  }
}