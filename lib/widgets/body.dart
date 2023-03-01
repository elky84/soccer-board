import 'package:flutter/material.dart';
import 'package:flutter_live_score_app/widgets/goalstat.dart';
import 'package:flutter_live_score_app/widgets/matchtile.dart';
import 'package:flutter_live_score_app/widgets/teamstat.dart';
import 'package:flutter_live_score_app/models/soccer.dart';

Widget pageBody(List<SoccerMatch> allmatches) {
  return Column(
    children: [
      Expanded(
        flex: 2,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  allmatches[0].league.logo,
                  width: 36.0,
                ),
                Text(
                  "${allmatches[0].league.country} ${allmatches[0].league.name}",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                teamStat("Local Team", allmatches[0].home.logoUrl,
                    allmatches[0].home.name),
                goalStat(allmatches[0].fixture, allmatches[0].goal.home,
                    allmatches[0].goal.away),
                teamStat("Visitor Team", allmatches[0].away.logoUrl,
                    allmatches[0].away.name),
              ],
            ),
          ),
        ),
      ),
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
                Text(
                  "MATCHES",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
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
