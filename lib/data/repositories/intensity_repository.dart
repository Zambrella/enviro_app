import 'dart:convert';

import 'package:enviro_app/data/models/statistics.dart';

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
}
