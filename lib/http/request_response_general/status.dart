class Status {
  bool correctResponse = false;

  Status(this.correctResponse);

  Status.fromJson(Map json) {
    correctResponse = json['correctResponse'];
  }
}