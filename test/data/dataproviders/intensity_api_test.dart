import 'package:enviro_app/data/dataproviders/intesity_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  test('checks that national intensity works and returns a string', () async {
    // Instantiate the mock client
    final client = MockClient();

    // Expected JSON response body
    final mockJson = '''
{
 "data": [
    {
      "from": "2021-01-19T16:30Z",
      "to": "2021-01-19T17:00Z",
        "intensity": {
          "forecast": 233,
          "actual": 223,
          "index": "moderate"
        }
    }
  ]
}
    ''';
    IntensityApi intensityApi = IntensityApi();

    // when calls a method on a mock class
    // whenComplete calls a function when a future completes
    when(client.get('https://api.carbonintensity.org.uk/intensity'))
        .thenAnswer((_) async => http.Response(mockJson, 200));

    // run the test
    expect(
        await intensityApi.getCurrentNationalIntesity(client), isA<String>());
  });

  test('checks that national intensity throws the correct error', () async {
    final client = MockClient();
    IntensityApi intensityApi = IntensityApi();

    when(client.get('https://api.carbonintensity.org.uk/intensity'))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    expect(intensityApi.getCurrentNationalIntesity(client),
        throwsA(isA<Exception>()));
  });
}
