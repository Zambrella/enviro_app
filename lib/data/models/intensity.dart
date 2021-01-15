import 'dart:convert';

import 'package:enviro_app/constants/enums.dart';

class Intensity {
  DateTime from;
  DateTime to;
  int forecast;
  int actual;
  IntensityIndex intensityIndex;

  Intensity(
      {this.from, this.to, this.forecast, this.actual, this.intensityIndex});

  Map<String, dynamic> toMap() {
    return {
      // 'from': from?.millisecondsSinceEpoch,
      // 'to': to?.millisecondsSinceEpoch,
      'forecast': forecast,
      'actual': actual,
    };
  }

  factory Intensity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Intensity(
      // from: DateTime.fromMillisecondsSinceEpoch(map['from']),
      // to: DateTime.fromMillisecondsSinceEpoch(map['to']),
      forecast: map['data'][0]['intensity']['forecast'],
      actual: map['data'][0]['intensity']['actual'],
      intensityIndex:
          convertStringToIntensityIndex(map['data'][0]['intensity']['index']),
    );
  }

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

  String toJson() => json.encode(toMap());

  factory Intensity.fromJson(String source) =>
      Intensity.fromMap(json.decode(source));

  // Getter to turn IntensityIndex enum into a string
  String get intensityIndexString {
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
