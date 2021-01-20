import 'package:enviro_app/data/dataproviders/intesity_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
// Instantiate the mock client
  final client = MockClient();
  group('Intensity API - ', () {
    group('Get current national intensity - ', () {
      // Expected JSON response body
      final mockJson =
          '''{"data": [{"from": "2021-01-19T16:30Z","to": "2021-01-19T17:00Z","intensity": {"forecast": 233,"actual": 223,"index": "moderate"}}]}''';

      test('When called and is successful, a string is returned', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get('https://api.carbonintensity.org.uk/intensity'))
            .thenAnswer((_) async => http.Response(mockJson, 200));

        //* Result
        expect(await intensityApi.getCurrentNationalIntesity(client),
            isA<String>());
      });

      test('When called and is unsuccessful, an exception is thrown', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get('https://api.carbonintensity.org.uk/intensity'))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //* Result
        expect(intensityApi.getCurrentNationalIntesity(client),
            throwsA(isA<Exception>()));
      });
    });

    group('Get 48hr National Statistics', () {
      final mockJson =
          '''{"data":[{"from": "2018-01-20T12:00Z","to": "2018-01-20T12:30Z","intensity": {"max": 320,"average": 266,"min": 180,"index": "moderate"}}]}''';
      final before = DateTime(2020, 12, 05, 10, 35);
      final after = DateTime(2020, 12, 07, 10, 35);

      test('When called and is successful, and a string is returned', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get(
                'https://api.carbonintensity.org.uk/intensity/stats/${before.toIso8601String()}/${after.toIso8601String()}'))
            .thenAnswer((_) async => http.Response(mockJson, 200));

        //* Result
        expect(
            await intensityApi.get48hrNationalStatistics(client, before, after),
            isA<String>());
      });

      test('When called and is unsuccessful, an exception is thrown', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get(
                'https://api.carbonintensity.org.uk/intensity/stats/${before.toIso8601String()}/${after.toIso8601String()}'))
            .thenAnswer((_) async => http.Response('Not found', 404));

        //* Result
        expect(intensityApi.get48hrNationalStatistics(client, before, after),
            throwsA(isA<Exception>()));
      });
    });

    group('Get 48 hour National Intensity', () {
      final mockJson =
          '''{"data":[{"from": "2018-01-20T12:00Z","to": "2018-01-20T12:30Z","intensity": {"forecast": 266,"actual": 263,"index": "moderate"}},{"from": "2018-01-20T12:00Z","to": "2018-01-20T12:30Z","intensity": {"forecast": 266,"actual": 263,"index": "moderate"}]} ''';
      final before = DateTime(2020, 12, 05, 10, 35);

      test('When called and is successful, and a string is returned', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get(
                'https://api.carbonintensity.org.uk/intensity/${before.toIso8601String()}/fw48h'))
            .thenAnswer((_) async => http.Response(mockJson, 200));

        //* Result
        expect(await intensityApi.get48hrNationalIntensity(client, before),
            isA<String>());
      });

      test('When called and is unsuccessful, an exception is thrown', () async {
        //* Setup
        IntensityApi intensityApi = IntensityApi();
        when(client.get(
                'https://api.carbonintensity.org.uk/intensity/${before.toIso8601String()}/fw48h'))
            .thenAnswer((_) async => http.Response('Not found', 404));

        //* Result
        expect(intensityApi.get48hrNationalIntensity(client, before),
            throwsA(isA<Exception>()));
      });
    });
  });
}
