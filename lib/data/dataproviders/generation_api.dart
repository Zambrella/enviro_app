import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class GenerationApi {
  static const baseURL = 'https://api.carbonintensity.org.uk';

  Future<String> getTimePeriodNationalMix(
      {@required http.Client client,
      @required DateTime from,
      @required DateTime to}) async {
    final _url =
        '$baseURL/generation/${from.toIso8601String()}/${to.toIso8601String()}';

    var response = await client.get(_url);
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      case 400:
        throw Exception('400 Error: Bad Request');
        break;
      case 500:
        throw Exception('500 Error: Internal Server Error');
        break;
      default:
        throw Exception('Unknown Error');
        break;
    }
  }
}
