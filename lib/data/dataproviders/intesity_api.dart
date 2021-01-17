import 'package:http/http.dart' as http;

class IntensityApi {
  Future<String> getCurrentNationalIntesity() async {
    var url = 'https://api.carbonintensity.org.uk/intensity';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> get48hrNationalStatistics() async {
    DateTime now = DateTime.now();
    DateTime next48 = DateTime.now().add(Duration(hours: 48));
    var url =
        'https://api.carbonintensity.org.uk/intensity/stats/${now.toIso8601String()}/${next48.toIso8601String()}';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> get48hrNationalIntensity() async {
    DateTime now = DateTime.now();
    var url =
        'https://api.carbonintensity.org.uk/intensity/${now.toIso8601String()}/fw48h';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
