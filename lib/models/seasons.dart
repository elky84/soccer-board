class Seasons {
  List<int> list;

  Seasons(this.list);

  factory Seasons.fromJson(dynamic json) {
    return Seasons((json['response'] as List).map((e) => e as int).toList());
  }
}
