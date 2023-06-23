import 'dart:convert';
import 'package:flutter_live_score_app/models/leagues.dart';
import 'package:http/http.dart';
import 'package:flutter_live_score_app/models/soccer_match.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SoccerApi {
  static Map<String, String> headers = {
    'x-rapidapi-host': "v3.football.api-sports.io"
  };

  static void setup() {
    headers["x-rapidapi-key"] = dotenv.get("RAPID_API_KEY");
  }

  Future<List<SoccerMatch>> getAllMatches(int league, int season) async {
    var url = Uri.https("v3.football.api-sports.io", "fixtures",
        {'season': season.toString(), 'league': league.toString()});
    var res = await get(url, headers: headers);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      return matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();
    } else {
      return <SoccerMatch>[];
    }
  }

  Future<List<Leagues>> getLeagues() async {
    var url =
        Uri.https("v3.football.api-sports.io", "leagues", {'type': 'league'});
    var res = await get(url, headers: headers);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<dynamic> list = body['response'];
      return list.map((dynamic item) => Leagues.fromJson(item)).toList();
    } else {
      return <Leagues>[];
    }
  }
}
