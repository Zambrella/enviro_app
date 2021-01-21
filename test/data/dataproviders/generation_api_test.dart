import 'package:enviro_app/data/dataproviders/generation_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Create a Mock http client
class MockClient extends Mock implements http.Client {}

void main() {
  var mockClient = MockClient();
  group('GenerationAPI - ', () {
    group('getTimePeriodNationalMix()', () {
      var from = DateTime(2020, 12, 10, 13, 24);
      var to = DateTime(2020, 12, 17, 13, 24);
      var url =
          'https://api.carbonintensity.org.uk/generation/${from.toIso8601String()}/${to.toIso8601String()}';

      test('Return a string when a successful call to the API is made',
          () async {
        //* setup
        var generationApi = GenerationApi();
        when(mockClient.get('$url'))
            .thenAnswer((_) async => http.Response('Here is a json', 200));

        //* action
        var response = await generationApi.getTimePeriodNationalMix(
            client: mockClient, from: from, to: to);

        //* test
        expect(response, isA<String>());
      });

      test('Throw an error when API call is unsuccessful', () async {
        //* setup
        var generationApi = GenerationApi();
        when(mockClient.get('$url'))
            .thenAnswer((_) async => http.Response('Bad Request', 400));

        //* action & test
        expect(
            generationApi.getTimePeriodNationalMix(
                client: mockClient, from: from, to: to),
            throwsA(isA<Exception>()));
      });
    });
  });
}
