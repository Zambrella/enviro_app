import 'dart:convert';

import 'package:enviro_app/constants/functions.dart';

import '../../constants/enums.dart';

class Intensity {
  DateTime from;
  DateTime to;
  int forecast;
  int actual;
  IntensityIndex intensityIndex;

  Intensity({
    this.from,
    this.to,
    this.forecast,
    this.actual,
    this.intensityIndex,
  });

  Map<String, dynamic> toMap() {
    //! This will not work
    return {
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'forecast': forecast,
      'actual': actual,
      'index': IndexHelper.intensityIndexAsString
    };
  }

  factory Intensity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Intensity(
      from: DateTime.parse(map['from']),
      to: DateTime.parse(map['to']),
      forecast: map['intensity']['forecast'],
      actual: map['intensity']['actual'],
      intensityIndex:
          IndexHelper.convertStringToIntensityIndex(map['intensity']['index']),
    );
  }

  // Not used
  String toJson() => json.encode(toMap());

  // No used
  factory Intensity.fromJson(String source) =>
      Intensity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Intensity(from: $from, to: $to, forecast: $forecast, actual: $actual)';
  }
}
