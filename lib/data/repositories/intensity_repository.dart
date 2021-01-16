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

  Future<Intensity> get24hrNationalStatistics() async {
    try {
      String rawData = await api.getCurrentNationalIntesity();
      Intensity intensity = Intensity.fromJson(rawData);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
