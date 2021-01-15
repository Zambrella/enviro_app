import 'package:http/http.dart' as http;

class IntensityApi {
  Future<String> getNationalIntesity() async {
    var url = 'https://api.carbonintensity.org.uk/intensity';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
