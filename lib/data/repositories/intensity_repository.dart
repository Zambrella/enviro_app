import 'dart:convert';

import '../models/statistics.dart';
import '../models/time_section.dart';

import '../dataproviders/intesity_api.dart';
import '../models/intensity.dart';

import 'package:http/http.dart' as http;

extension DateTimeExtension on DateTime {
  DateTime roundDown({Duration delta = const Duration(minutes: 60)}) {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds);
  }
}

class IntensityRepository {
  final IntensityApi api = IntensityApi();
  http.Client client = http.Client();
  var now = DateTime.now();
  var next48 = DateTime.now().add(Duration(hours: 48));

  Future<Intensity> getNationalIntesity() async {
    try {
      String rawData = await api.getCurrentNationalIntesity(client);
      Map<String, dynamic> decoded = jsonDecode(rawData)['data'][0];
      Intensity intensity = Intensity.fromMap(decoded);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Intensity>> getNationIntensityAtSpecificTime(
      List<DateTime> dateTimes) async {
    List<Intensity> intensities = [];
    try {
      for (DateTime dateTime in dateTimes) {
        String rawData =
            await api.getSpecificTimePeriodIntensity(client, dateTime);
        Map<String, dynamic> decoded = jsonDecode(rawData)['data'][0];
        Intensity intensity = Intensity.fromMap(decoded);
        intensities.add(intensity);
      }
      return intensities;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<IntensityStatistics> get48hrNationalStatistics() async {
    try {
      String rawData = await api.get48hrNationalStatistics(client, now, next48);
      Map<String, dynamic> decoded = jsonDecode(rawData)['data'][0];
      IntensityStatistics intensityStats = IntensityStatistics.fromMap(decoded);
      return intensityStats;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Helper function to get a list of Intensity objects
  Future<List<Intensity>> get48hrNationalIntensity() async {
    try {
      String rawData = await api.get48hrNationalIntensity(client, now);
      var decoded = jsonDecode(rawData)['data'];
      List<Intensity> intensityList = [];
      decoded.forEach((element) {
        intensityList.add(Intensity.fromMap(element));
      });
      return intensityList;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<TimeSection>> getTimeSections() async {
    // First step is to get all the Intensity objects within the 48 hr time period
    var intensities = await get48hrNationalIntensity();
    // Next is to round down to the nearest 30 minutes because API spits data out on the hour and 30 past hour
    // Todo: Get it to round down to nearest even hour
    var now = DateTime.now().roundDown();
    List<TimeSection> timeSections = [];
    try {
      for (var i = 0; i <= 46; i += 2) {
        // Get earliest time period
        var beginTime = now.add(Duration(hours: i));

        // Get latest timer period
        var endTime = now.add(Duration(hours: i + 2));

        // Create a list of Intensity objects that are between the 2 time periods
        var filteredList = intensities.where((element) {
          return (element.from.isAfter(beginTime) ||
                  element.from.isAtSameMomentAs(beginTime)) &&
              element.to.isBefore(endTime);
        }).toList();

        // Create a TimeSection object with the desired properties
        timeSections.add(
          TimeSection(
            from: beginTime,
            to: endTime,
            // Add all Intensity objects to the list where they are within the 2 hour time range
            intensities: filteredList,
          ),
        );
      }
      return timeSections;
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
