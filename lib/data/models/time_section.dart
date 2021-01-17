import 'package:flutter/material.dart';

import 'package:enviro_app/data/models/intensity.dart';

class TimeSection {
  List<Intensity> intensities;
  DateTime to;
  DateTime from;

  TimeSection(
      {@required this.intensities, @required this.to, @required this.from});

  @override
  String toString() =>
      'TimeSection(intensities: $intensities, to: $to, from: $from)';
}
