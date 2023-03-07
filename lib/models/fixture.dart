import 'status.dart';

class Fixture {
  int id;
  DateTime date;
  Status status;
  Fixture(this.id, this.date, this.status);

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(json['id'], DateTime.parse(json['date']),
        Status.fromJson(json['status']));
  }
}
