class Country {
  String name;
  String code;
  String flag;

  Country(this.name, this.code, this.flag);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['name'], json['code'], json['flag']);
  }
}
