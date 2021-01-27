import 'package:flutter/material.dart';

import 'intensity.dart';

class TimeSection {
  List<Intensity> intensities;
  DateTime to;
  DateTime from;

  TimeSection(
      {@required this.intensities, @required this.to, @required this.from});

  @override
  String toString() =>
      'TimeSection(intensities: $intensities, to: $to, from: $from)';

  int get intensityAverage {
    var sum = 0;
    var count = 0;
    for (var intensity in intensities) {
      sum += intensity.forecast;
      count++;
    }
    return (sum / count).round();
  }
}
