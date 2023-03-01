import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/soccer.dart';

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
