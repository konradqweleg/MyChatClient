class StatusMessage {
  bool _isError = false;
  String _errorMessage = "";

  StatusMessage({required bool isError, String errorMessage = ""}) {
    if (isError) {
      _isError = isError;
      _errorMessage = errorMessage;
    }

    if (!isError && errorMessage.isNotEmpty) {
      throw Exception("Error: isError is false and errorMessage is not empty");
    }
  }

  factory StatusMessage.noError() {
    return StatusMessage(isError: false);
  }

  factory StatusMessage.error(String errorMessage) {
    return StatusMessage(isError: true,errorMessage: errorMessage);
  }

  bool isError() {
    return _isError;
  }

  String getErrorMessage() {
    if (_errorMessage.isEmpty) {
      throw Exception("Error: errorMessage is empty");
    }
    return _errorMessage;
  }
}