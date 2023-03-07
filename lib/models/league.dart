class League {
  int id;
  String name;
  String country;
  String logo;
  String flag;
  int season;
  String round;

  League(this.id, this.name, this.country, this.logo, this.flag, this.season,
      this.round);

  factory League.fromJson(Map<String, dynamic> json) {
    return League(json['id'], json['name'], json['country'], json['logo'],
        json['flag'], json['season'], json['round']);
  }
}
