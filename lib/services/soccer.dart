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
    var url =
        "https://v3.football.api-sports.io/fixtures?season=${season}&league=${league}";
    Response res = await get(url, headers: headers);
    var body;

    if (res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service: $body");
      return matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();
    } else {
      return <SoccerMatch>[];
    }
  }

  Future<List<Leagues>> getLeagues() async {
    var url = "https://v3.football.api-sports.io/leagues?type=league";
    Response res = await get(url, headers: headers);
    var body;

    if (res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> list = body['response'];
      print("Api service: $body");
      return list.map((dynamic item) => Leagues.fromJson(item)).toList();
    } else {
      return <Leagues>[];
    }
  }
}
