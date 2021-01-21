import 'package:enviro_app/data/repositories/intensity_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  group('Intensity Repository - ', () {
    final client = MockClient();
    group('Get national intensity - ', () {
      test(
          'Given a valid string from a successful API call, return an Intensity object with correct properties',
          () async {
        //* Setup
        final String rawJson =
            '''{"data": [{"from": "2021-01-19T16:30Z","to": "2021-01-19T17:00Z","intensity": {"forecast": 233,"actual": 223,"index": "moderate"}}]}''';
        IntensityRepository intensityRepository = IntensityRepository();
        when(client.get('https://api.carbonintensity.org.uk/intensity'))
            .thenAnswer((_) async => http.Response(rawJson, 200));
        intensityRepository.client = client;
        var intensity = await intensityRepository.getNationalIntesity();

        //* Result
        expect(intensity.actual, equals(223));
      });

      test('Given an invalid string from a successful API call, throw an error',
          () async {
        //* Setup
        final String rawJson =
            '''{invalid}{"data": [{"from": "2021-01-19T16:30Z","to": "2021-01-19T17:00Z","intensity": {"forecast": 233,"actual": 223,"index": "moderate"}}]}''';
        IntensityRepository intensityRepository = IntensityRepository();
        when(client.get('https://api.carbonintensity.org.uk/intensity'))
            .thenAnswer((_) async => http.Response(rawJson, 200));
        intensityRepository.client = client;

        //* Result
        expect(intensityRepository.getNationalIntesity(),
            throwsA(isA<Exception>()));
      });
    });

    group('Get 48hour National Statistics - ', () {
      test(
          'Given a valid string from a succeeesful API call, return an IntensityStatics object with correct properties',
          () async {
        //* Setup
        final before = DateTime(2020, 12, 05, 10, 35);
        final after = DateTime(2020, 12, 07, 10, 35);
        final String rawJson =
            '''{"data":[{"from": "2018-01-20T12:00Z","to": "2018-01-20T12:30Z","intensity": {"max": 320,"average": 266,"min": 180,"index": "moderate"}}]}''';
        IntensityRepository intensityRepository = IntensityRepository();
        intensityRepository.client = client;
        intensityRepository.now = before;
        intensityRepository.next48 = after;
        when(client.get(
                'https://api.carbonintensity.org.uk/intensity/stats/${before.toIso8601String()}/${after.toIso8601String()}'))
            .thenAnswer((_) async => http.Response(rawJson, 200));
        var statistics = await intensityRepository.get48hrNationalStatistics();

        //* Result
        expect(statistics.max, equals(320));
      });
    });
  });
}

//Todo: I think I need to create a mock api class so that I don't need to mock the client?
