import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

import 'enums.dart';

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

class IndexHelper {
  // Function to convert a string from the api into a IntensityIndex enum
  // This may seem unneccesary but might make it easier to work with
  static IntensityIndex convertStringToIntensityIndex(String input) {
    // API sends them as lower case but just in case it changes
    var index = input.toLowerCase();
    switch (index) {
      case 'very low':
        return IntensityIndex.VeryLow;
        break;
      case 'low':
        return IntensityIndex.Low;
        break;
      case 'moderate':
        return IntensityIndex.Moderate;
        break;
      case 'high':
        return IntensityIndex.High;
        break;
      case 'very high':
        return IntensityIndex.VeryHigh;
        break;
      default:
        return IntensityIndex.Unknown;
        break;
    }
  }

  // Getter to turn IntensityIndex enum into a string
  // Needed to toMap function and likely for the UI
  static String intensityIndexAsString(IntensityIndex intensityIndex) {
    switch (intensityIndex) {
      case IntensityIndex.VeryLow:
        return 'very low';
        break;
      case IntensityIndex.Low:
        return 'low';
        break;
      case IntensityIndex.Moderate:
        return 'moderate';
        break;
      case IntensityIndex.High:
        return 'high';
        break;
      case IntensityIndex.VeryHigh:
        return 'very high';
        break;
      case IntensityIndex.Unknown:
        return 'unknown';
        break;
      default:
        return 'unknown';
        break;
    }
  }
}
