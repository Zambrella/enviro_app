import 'package:enviro_app/data/dataproviders/intesity_api.dart';
import 'package:enviro_app/data/models/intensity.dart';

class IntensityRepository {
  // Intesity API will be created when this class is instantiated
  final IntensityApi api = IntensityApi();

  Future<Intensity> getNationalIntesity() async {
    try {
      String rawData = await api.getNationalIntesity();
      Intensity intensity = Intensity.fromJson(rawData);
      return intensity;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
