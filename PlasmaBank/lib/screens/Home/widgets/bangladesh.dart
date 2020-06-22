/*class Bangladesh {
  String totalCases;
  String newCases;
  String deaths;
  String newDeaths;
  String recovered;
  String active;
  String totalTests;
  String updatedOn;
  String testConducted;
  String totalTestConducted;
  String positiveCases;
  String confirmed;

  Bangladesh({
    this.totalCases,
    this.newCases,
    this.deaths,
    this.newDeaths,
    this.recovered,
    this.active,
    this.totalTests,
    this.updatedOn,
    this.testConducted,
    this.totalTestConducted,
    this.positiveCases,
    this.confirmed
  });
  factory Bangladesh.fromJson(Map<String, dynamic> json) {
    return Bangladesh(
        totalCases: json["Total Cases"],
        newCases: json["New Cases(24hrs)"],
        deaths: json["Deaths"],
        newDeaths: json["New Deaths(24hrs)"],
        recovered: json["Recovered"],
        active: json["Active"],
        totalTests: json["Total Tests"]);
  
  }
}*/
import 'dart:convert';

import 'package:PlasmaBank/screens/Home/widgets/api.dart';

class Name {
  Name({
    this.name,
    this.info,
  });

  String name;
  Info info;

  factory Name.fromJson(Map<String, dynamic> json) {
    final _data = jsonDecode(json['info']);
    return Name(
      name: json['name'],
      info: Info.fromJson(_data),
    );
  }
}

class Info {
  Info({
    this.summary,
    this.test,
  });
  
  List<List<dynamic>> summary;
  List<List<String>> test;
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      summary: List<List<dynamic>>.from(json['summary'].map(
          (element) => List<dynamic>.from(element.map((element) => element)))),
      test: List<List<String>>.from(json['test'].map(
          (element) => List<String>.from(element.map((element) => element)))),
    );
  }
}

/*const data = {
  "name": "Bangladesh",
  "info":
      "{\"summary\": [[\"DataSource\", \"Worldometers\"], [\"Country\", \"Bangladesh\"], [\"Total Cases\", 112306], [\"New Cases(24hrs)\", \"0\"], [\"Deaths\", 1464], [\"New Deaths(24hrs)\", \"0\"], [\"Recovered\", 45077], [\"Active\", 65765], [\"Total Tests\", 615164]], \"test\": [[\"Updated on 21-05-2020\", \"Total\"], [\"Test conducted (24hrs)\", \"10262\"], [\"Total test conducted\", \"214114\"], [\"Positive cases (24hrs)\", \"1773\"], [\"Confirmed\", \"28511\"]]}"
};*/

