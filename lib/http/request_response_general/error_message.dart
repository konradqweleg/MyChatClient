class ErrorMessageData{
  String errorMessage = "";
  ErrorMessageData.fromJson(Map json) {
    errorMessage = json['ErrorMessage'];
  }
}