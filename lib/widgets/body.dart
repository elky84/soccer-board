import 'package:flutter/material.dart';
import 'package:flutter_live_score_app/models/leagues.dart';
import 'package:flutter_live_score_app/models/soccer_match.dart';
import 'package:intl/intl.dart';

import '../models/fixture.dart';
import '../services/soccer.dart';

class SoccerAppBody extends StatefulWidget {
  final List<Leagues> leagues;

  const SoccerAppBody({Key key, this.leagues}) : super(key: key);

  @override
  _SoccerAppBodyState createState() => _SoccerAppBodyState();
}

class _SoccerAppBodyState extends State<SoccerAppBody> {
  int season = null;
  Leagues league = null;

  List<int> seasons = [];

  List<SoccerMatch> allmatches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: pageBody(widget.leagues));
  }

  void _show() async {
    if (league == null) return;

    var matches = await SoccerApi().getAllMatches(league.id, season);
    setState(() {
      this.allmatches = matches;
    });
  }

  Widget pageBody(List<Leagues> leagues) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(5),
              height: 25,
              width: 50,
              child: const Text('League',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DropdownButton(
              value: this.league,
              items: leagues.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(value.logo),
                          SizedBox(
                            width: 5,
                          ),
                          Text(value.name)
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    league = value;
                    seasons = league.seasons.map((e) => e.year).toList();
                  }
                });
              }),
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.all(5),
              height: 25,
              width: 50,
              child: const Text('Seasons',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
          DropdownButton(
              value: this.season,
              items: this.seasons.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value.toString()),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    season = value;
                  }
                });
              }),
          Container(
              margin: const EdgeInsets.all(5),
              child: ElevatedButton(
                  onPressed: _show,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff0165E1),
                    ),
                  ),
                  child: const Text('Show'))),
        ]),
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  matchesTitle(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allmatches.length,
                      itemBuilder: (context, index) {
                        return matchTile(allmatches[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget matchesTitle() {
    if (allmatches.isEmpty) {
      return Text(
        "Need to select League & Season",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
      );
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(league.logo, width: 30),
          SizedBox(width: 10),
          Text(
            "${league.name} Matches",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          )
        ]);
  }

  Widget goalStat(Fixture fixture, int homeGoal, int awayGoal) {
    var home = homeGoal;
    var away = awayGoal;
    var elapsed = fixture.status.elapsedTime;
    if (home == null) home = 0;
    if (away == null) away = 0;
    if (elapsed == null) elapsed = 0;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$elapsed'",
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          Text(
            "$home - $away",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36.0,
            ),
          ),
          Text(
            DateFormat("yyyy-MM-dd HH:mm").format(fixture.date),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget teamStat(String team, String logoUrl, String teamName) {
    return Expanded(
      child: Column(
        children: [
          Text(
            team,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Image.network(
              logoUrl,
              width: 54.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            teamName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}

Widget matchTile(SoccerMatch match) {
  var homeGoal = match.goal.home;
  var awayGoal = match.goal.away;
  if (homeGoal == null) homeGoal = 0;
  if (awayGoal == null) awayGoal = 0;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            "${match.league.round}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            match.home.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Image.network(
          match.home.logoUrl,
          width: 36.0,
        ),
        Expanded(
          child: Text(
            "$homeGoal - $awayGoal",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Image.network(
          match.away.logoUrl,
          width: 36.0,
        ),
        Expanded(
          child: Text(
            match.away.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}
