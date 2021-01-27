import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../dataproviders/generation_api.dart';
import '../models/generation.dart';

class GenerationRepository {
  var generationApi = GenerationApi();
  var client = http.Client();

  Future<List<Generation>> getGenerationMix(
      {@required DateTime from, @required DateTime to}) async {
    try {
      var rawData = await generationApi.getTimePeriodNationalMix(
          client: client, from: from, to: to);
      // print('Generation Repository - rawData: $rawData');
      var decoded = jsonDecode(rawData)['data'];
      List<Generation> generationList = [];
      decoded.forEach((element) {
        generationList.add(Generation.fromMap(element));
      });
      return generationList;
    } catch (e) {
      print(e);
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, double>> getAverageGenerationMix(
      {@required DateTime from, @required DateTime to}) async {
    // Get all the Generation objects in the given time period
    var generationList = await getGenerationMix(from: from, to: to);
    // Next we will want to iterate through each generation object and extract each generation type
    // and store them
    List<GenerationType> biomass = [];
    List<GenerationType> coal = [];
    List<GenerationType> imports = [];
    List<GenerationType> gas = [];
    List<GenerationType> nuclear = [];
    List<GenerationType> other = [];
    List<GenerationType> hydro = [];
    List<GenerationType> solar = [];
    List<GenerationType> wind = [];

    generationList.forEach(
      (generationList) => generationList.generation.forEach(
        (e) {
          switch (e.generationName) {
            case ('biomass'):
              biomass.add(e);
              break;
            case ('coal'):
              coal.add(e);
              break;
            case ('imports'):
              imports.add(e);
              break;
            case ('gas'):
              gas.add(e);
              break;
            case ('nuclear'):
              nuclear.add(e);
              break;
            case ('other'):
              other.add(e);
              break;
            case ('hydro'):
              hydro.add(e);
              break;
            case ('solar'):
              solar.add(e);
              break;
            case ('wind'):
              wind.add(e);
              break;
          }
        },
      ),
    );

    // After all the lists have been filled with the corect generation we need to calculate the average for each of them
    var biomassAvrg = calculateAverage(biomass);
    var coalAvrg = calculateAverage(coal);
    var importsAvrg = calculateAverage(imports);
    var gasAvrg = calculateAverage(gas);
    var nuclearAvrg = calculateAverage(nuclear);
    var otherAvrg = calculateAverage(other);
    var hydroAvrg = calculateAverage(hydro);
    var solarAvrg = calculateAverage(solar);
    var windAvrg = calculateAverage(wind);

    // Finally we want to return all the values as a map (I think?)
    return {
      'biomass': biomassAvrg,
      'nuclear': nuclearAvrg,
      'wind': windAvrg,
      'hydro': hydroAvrg,
      'solar': solarAvrg,
      'other': otherAvrg,
      'imports': importsAvrg,
      'coal': coalAvrg,
      'gas': gasAvrg
    };
  }

  // Helper function to calculate average
  double calculateAverage(List<GenerationType> listOfGenerationType) {
    double sum = 0;
    var length = listOfGenerationType.length;
    listOfGenerationType.forEach((element) {
      sum += element.generationPercentage;
    });
    return sum / length;
  }
}
