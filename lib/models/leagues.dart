import 'package:flutter_live_score_app/models/country.dart';

import 'season.dart';

class Leagues {
  int id;
  String name;
  String logo;

  Country country;

  List<Season> seasons;

  Leagues(this.id, this.name, this.logo, this.country, this.seasons);

  factory Leagues.fromJson(Map<String, dynamic> json) {
    List<dynamic> seasons = json['seasons'];
    dynamic league = json['league'];
    return Leagues(
        league['id'],
        league['name'],
        league['logo'],
        Country.fromJson(json['country']),
        seasons.map((dynamic item) => Season.fromJson(item)).toList());
  }
}
