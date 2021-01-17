import 'dart:convert';

import 'package:enviro_app/data/models/statistics.dart';
import 'package:enviro_app/data/models/time_section.dart';

import '../dataproviders/intesity_api.dart';
import '../models/intensity.dart';

class IntensityRepository {
  final IntensityApi api = IntensityApi();

  Future<Intensity> getNationalIntesity() async {
    try {
      String rawData = await api.getCurrentNationalIntesity();
      Map<String, dynamic> decoded = jsonDecode(rawData)['data'][0];
      Intensity intensity = Intensity.fromMap(decoded);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<IntensityStatistics> get48hrNationalStatistics() async {
    try {
      String rawData = await api.get48hrNationalStatistics();
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
      String rawData = await api.get48hrNationalIntensity();
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
    //! I think I will need to round now to the earliest 30 mins e.g. 12:45 -> 12:30
    var now = DateTime.now();
    List<TimeSection> timeSections = [];
    try {
      for (var i = 0; i <= 46; i += 2) {
        // Get earliest time period
        var beginTime = now.add(Duration(hours: i));

        // Get latest timer period
        var endTime = now.add(Duration(hours: i + 2));

        // Create a list of Intensity objects that are between the 2 time periods
        var filteredList = intensities.where((element) {
          return element.from.isAfter(beginTime) &&
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
