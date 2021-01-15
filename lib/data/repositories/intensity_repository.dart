import '../dataproviders/intesity_api.dart';
import '../models/intensity.dart';

class IntensityRepository {
  final IntensityApi api = IntensityApi();

  Future<Intensity> getNationalIntesity() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      String rawData = await api.getNationalIntesity();
      Intensity intensity = Intensity.fromJson(rawData);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
