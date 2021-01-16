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

  Future<String> get24hrNationalStatistics() async {
    DateTime now = DateTime.now();
    DateTime next24 = DateTime.now().add(Duration(hours: 24));
    var url =
        'https://api.carbonintensity.org.uk/intensity/stats/${now.toIso8601String()}/${next24.toIso8601String()}';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
