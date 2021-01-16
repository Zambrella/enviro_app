import 'package:enviro_app/data/models/statistics.dart';

import '../dataproviders/intesity_api.dart';
import '../models/intensity.dart';

class IntensityRepository {
  final IntensityApi api = IntensityApi();

  Future<Intensity> getNationalIntesity() async {
    try {
      String rawData = await api.getCurrentNationalIntesity();
      Intensity intensity = Intensity.fromJson(rawData);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<IntensityStatistics> get24hrNationalStatistics() async {
    try {
      String rawData = await api.get24hrNationalStatistics();
      IntensityStatistics intensityStats =
          IntensityStatistics.fromJson(rawData);
      return intensityStats;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
