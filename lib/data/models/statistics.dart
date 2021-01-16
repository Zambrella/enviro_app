import 'dart:convert';

import 'package:enviro_app/constants/enums.dart';
import 'package:enviro_app/constants/functions.dart';

class IntensityStatistics {
  DateTime from;
  DateTime to;
  int max;
  int average;
  int min;
  IntensityIndex intensityIndex;

  IntensityStatistics({
    this.from,
    this.to,
    this.max,
    this.average,
    this.min,
    this.intensityIndex,
  });

  Map<String, dynamic> toMap() {
    //! This will not work
    return {
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'max': max,
      'average': average,
      'min': min,
      'index': IndexHelper.intensityIndexAsString
    };
  }

  factory IntensityStatistics.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return IntensityStatistics(
      from: DateTime.parse(map['data'][0]['from']),
      to: DateTime.parse(map['data'][0]['to']),
      max: map['data'][0]['intensity']['max'],
      average: map['data'][0]['intensity']['average'],
      min: map['data'][0]['intensity']['min'],
      intensityIndex: IndexHelper.convertStringToIntensityIndex(
          map['data'][0]['intensity']['index']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IntensityStatistics.fromJson(String source) =>
      IntensityStatistics.fromMap(json.decode(source));
}