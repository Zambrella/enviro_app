import '../../constants/ui_constants.dart';
import 'package:flutter/material.dart';

class PieData {
  final String title;
  final double percentage;
  Color color;
  IconData icon;
  PieData({this.title, this.percentage}) {
    switch (this.title) {
      case ('biomass'):
        this.color = kVeryLow;
        this.icon = Icons.eco;
        break;
      case ('coal'):
        this.color = kVeryHigh;
        this.icon = Icons.whatshot;
        break;
      case ('imports'):
        this.color = kModerate;
        this.icon = Icons.local_shipping;
        break;
      case ('gas'):
        this.color = kVeryHigh;
        this.icon = Icons.local_gas_station;
        break;
      case ('nuclear'):
        this.color = kVeryLow;
        this.icon = Icons.science;
        break;
      case ('other'):
        this.color = kModerate;
        this.icon = Icons.battery_unknown;
        break;
      case ('hydro'):
        this.color = kVeryLow;
        this.icon = Icons.waves;
        break;
      case ('solar'):
        this.color = kVeryLow;
        this.icon = Icons.wb_sunny;
        break;
      case ('wind'):
        this.color = kVeryLow;
        this.icon = Icons.cloud;
        break;
    }
  }
}
