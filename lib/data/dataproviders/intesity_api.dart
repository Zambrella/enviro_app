import 'package:http/http.dart' as http;

class IntensityApi {
  static const baseURL = 'https://api.carbonintensity.org.uk';

  Future<String> getCurrentNationalIntesity(http.Client client) async {
    final _url = '$baseURL/intensity';

    var response = await client.get(_url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> get48hrNationalStatistics(http.Client client) async {
    DateTime _now = DateTime.now();
    DateTime _next48 = DateTime.now().add(Duration(hours: 48));
    var _url =
        '$baseURL/intensity/stats/${_now.toIso8601String()}/${_next48.toIso8601String()}';

    var response = await client.get(_url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> get48hrNationalIntensity(http.Client client) async {
    DateTime _now = DateTime.now();
    var _url = '$baseURL/intensity/${_now.toIso8601String()}/fw48h';
    var response = await client.get(_url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
