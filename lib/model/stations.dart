import 'dart:convert';
import 'package:flutter/services.dart';

class Station {
  final String code;
  final String name;

  Station({
    required this.code,
    required this.name,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }
}

Future<List<Station>> loadStations() async {
  final jsonFile = await rootBundle.loadString('assets/data/stations.json');
  final jsonData = jsonDecode(jsonFile) as Map<String, dynamic>;

  List<Station> stations = jsonData.keys.map((key) {
    return Station.fromJson({
      'code': key,
      'name': jsonData[key],
    });
  }).toList();

  return stations;
}
