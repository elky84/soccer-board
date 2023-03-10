class Season {
  int year;
  String start;
  String end;

  Season(this.year, this.start, this.end);

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(json['year'], json['start'], json['end']);
  }
}
