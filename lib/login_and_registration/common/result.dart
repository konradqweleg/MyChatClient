enum RequestStatus { SUCCESS, ERROR, UNKNOWN }

class Result<T> {
  RequestStatus _status = RequestStatus.UNKNOWN;
  T? data;

  Result.success(this.data) {
    _status = RequestStatus.SUCCESS;
  }

  Result.error(this.data) {
    _status = RequestStatus.ERROR;
  }

  RequestStatus get status => _status;

  Result.empty() {
    _status = RequestStatus.UNKNOWN;
  }

  T getData() {
    if (data == null) {
      throw Exception("Error: data is null");
    }
    return data!;
  }


  bool isResult() {
    return _status != RequestStatus.UNKNOWN;
  }

  bool isSuccess() {
    return _status == RequestStatus.SUCCESS;
  }

  bool isError() {
    return _status == RequestStatus.ERROR;
  }

  @override bool operator ==(Object other) =>
      identical(this, other) ||
          other is Result &&
              runtimeType == other.runtimeType &&
              _status == other._status &&
              data == other.data;

  @override int get hashCode => _status.hashCode ^ data.hashCode;
  @override String toString() {
    return 'Result{_status: $_status, data: $data}';
  }
}
