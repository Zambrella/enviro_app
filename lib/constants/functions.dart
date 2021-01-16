import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class UIFunctions {
  /// 0 - 99 = very low
  /// 100 - 179 = low
  /// 180 - 249 = moderate
  /// 250 - 349 = high
  /// 350+ = very high
  static Color getColor(int value) {
    if (value <= 99) {
      // very low
      return kVeryLow;
    } else if (value >= 100 && value <= 179) {
      // low
      return kLow;
    } else if (value >= 180 && value <= 249) {
      // moderate
      return kModerate;
    } else if (value >= 250 && value <= 349) {
      // high
      return kHigh;
    } else {
      // very high
      return kVeryHigh;
    }
  }
}
