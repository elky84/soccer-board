import 'package:flutter_live_score_app/models/team.dart';

import 'fixture.dart';
import 'goal.dart';
import 'league.dart';

class SoccerMatch {
  Fixture fixture;
  League league;
  Team home;
  Team away;
  Goal goal;

  SoccerMatch(this.fixture, this.league, this.home, this.away, this.goal);

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    return SoccerMatch(
        Fixture.fromJson(json['fixture']),
        League.fromJson(json['league']),
        Team.fromJson(json['teams']['home']),
        Team.fromJson(json['teams']['away']),
        Goal.fromJson(json['goals']));
  }
}
