import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_live_score_app/services/soccer.dart';
import 'package:flutter_live_score_app/widgets/body.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  SoccerApi.setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SoccerApp(),
    );
  }
}

class SoccerApp extends StatefulWidget {
  @override
  _SoccerAppState createState() => _SoccerAppState();
}

class _SoccerAppState extends State<SoccerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0.0,
          title: Text(
            "Soccer Board",
            style: TextStyle(color: Colors.black, fontSize: 38),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: SoccerApi().getLeagues(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SoccerAppBody(leagues: snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
