import 'package:enviro_app/data/models/intensity.dart';
import 'package:enviro_app/data/repositories/intensity_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final IntensityRepository intensityRepository = IntensityRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder<Intensity>(
          future: intensityRepository.getNationalIntesity(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Intensity intensity = snapshot.data;
              return Center(
                child: Column(
                  children: [
                    Text('Returned Data'),
                    Text('Forecast From: ${intensity.from}'),
                    Text('Forecast To: ${intensity.to}'),
                    Text('Forecast intensity: ${intensity.forecast}'),
                    Text('Actual intensity: ${intensity.actual}'),
                    Text('Index: ${intensity.intensityIndexAsString}'),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
