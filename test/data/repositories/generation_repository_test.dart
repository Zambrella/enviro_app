import 'package:enviro_app/data/dataproviders/generation_api.dart';
import 'package:enviro_app/data/models/generation.dart';
import 'package:enviro_app/data/repositories/generation_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApi extends Mock implements GenerationApi {}

void main() {
  final validJsonString = '''
{"data":[{"from":"2020-12-05T10:30Z","to":"2020-12-05T11:00Z","generationmix":[{"fuel":"biomass","perc":8.1},{"fuel":"coal","perc":0},{"fuel":"imports","perc":8.1},{"fuel":"gas","perc":49.1},{"fuel":"nuclear","perc":17.9},{"fuel":"other","perc":0},{"fuel":"hydro","perc":1.9},{"fuel":"solar","perc":4.8},{"fuel":"wind","perc":10}]},{"from":"2020-12-05T11:00Z","to":"2020-12-05T11:30Z","generationmix":[{"fuel":"biomass","perc":8},{"fuel":"coal","perc":0},{"fuel":"imports","perc":9.1},{"fuel":"gas","perc":48.3},{"fuel":"nuclear","perc":17.6},{"fuel":"other","perc":0},{"fuel":"hydro","perc":1.5},{"fuel":"solar","perc":6.9},{"fuel":"wind","perc":8.5}]},{"from":"2020-12-05T11:30Z","to":"2020-12-05T12:00Z","generationmix":[{"fuel":"biomass","perc":7.9},{"fuel":"coal","perc":0.8},{"fuel":"imports","perc":9.2},{"fuel":"gas","perc":48.5},{"fuel":"nuclear","perc":17.5},{"fuel":"other","perc":0},{"fuel":"hydro","perc":1.6},{"fuel":"solar","perc":6.9},{"fuel":"wind","perc":7.5}]},{"from":"2020-12-05T12:00Z","to":"2020-12-05T12:30Z","generationmix":[{"fuel":"biomass","perc":8.1},{"fuel":"coal","perc":1.5},{"fuel":"imports","perc":9.2},{"fuel":"gas","perc":48.3},{"fuel":"nuclear","perc":17.5},{"fuel":"other","perc":0},{"fuel":"hydro","perc":1.6},{"fuel":"solar","perc":6.4},{"fuel":"wind","perc":7.4}]}]}
''';
  var from = DateTime(2020, 12, 05, 10, 35);
  var to = DateTime(2020, 12, 05, 12, 35);
  group('Generation Repository - ', () {
    group('getGenerationMix() - ', () {
      test('Return a Generation list object when given valid string/json',
          () async {
        //* Setup
        var repository = GenerationRepository();
        var mockApi = MockApi();
        repository.generationApi = mockApi;
        when(mockApi.getTimePeriodNationalMix(
                client: repository.client, from: from, to: to))
            .thenAnswer((_) async => validJsonString);

        //* Action
        var generationList =
            await repository.getGenerationMix(from: from, to: to);

        //* Result
        expect(generationList, isA<List<Generation>>());
      });

      test(
          'Return a Generation list object with the correct properties when given a valid string/json',
          () async {
        //* Setup
        var repository = GenerationRepository();
        var mockApi = MockApi();
        repository.generationApi = mockApi;
        when(mockApi.getTimePeriodNationalMix(
                client: repository.client, from: from, to: to))
            .thenAnswer((_) async => validJsonString);

        //* Action
        var generationList =
            await repository.getGenerationMix(from: from, to: to);

        //* Result
        expect(
            generationList[1].generation[0].generationPercentage, equals(8.0));
      });
    });

    group('getAverageGenerationMix - ', () {
      test('Return a map of type String, double given a valid string/json',
          () async {
        //* Setup
        var repository = GenerationRepository();
        var mockApi = MockApi();
        repository.generationApi = mockApi;
        when(mockApi.getTimePeriodNationalMix(
                client: repository.client, from: from, to: to))
            .thenAnswer((_) async => validJsonString);

        //* Action
        Map<String, double> result =
            await repository.getAverageGenerationMix(from: from, to: to);

        //* Result
        expect(result, isA<Map<String, double>>());
      });

      test(
          'Return a map of type String, double with correct values given a valid string/json',
          () async {
        //* Setup
        var repository = GenerationRepository();
        var mockApi = MockApi();
        repository.generationApi = mockApi;
        when(mockApi.getTimePeriodNationalMix(
                client: repository.client, from: from, to: to))
            .thenAnswer((_) async => validJsonString);

        //* Action
        Map<String, double> result =
            await repository.getAverageGenerationMix(from: from, to: to);

        //* Result
        expect(result['coal'], equals(0.575));
      });
    });
  });
}
