class Status {
  bool correctResponse = false;
  Status.fromJson(Map json) {
    correctResponse = json['correctResponse'];
  }
}