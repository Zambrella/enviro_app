import '../../business_logic/cubits/cubit/intensity_cubit.dart';
import '../../data/repositories/intensity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final IntensityRepository intensityRepository = IntensityRepository();
  @override
  Widget build(BuildContext context) {
    return BlocListener<IntensityCubit, IntensityState>(
      listener: (context, state) {
        if (state is IntensityFetchSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data loaded'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<IntensityCubit, IntensityState>(
                  builder: (context, state) {
                if (state is IntensityInitial) {
                  return Text('Press the button below');
                } else if (state is IntensityFetchInProgress) {
                  return CircularProgressIndicator();
                }
                return Container();
              }),
              BlocBuilder<IntensityCubit, IntensityState>(
                  builder: (context, state) {
                if (state is IntensityInitial ||
                    state is IntensityFetchInProgress) {
                  return RaisedButton(
                    onPressed: () {
                      context.read<IntensityCubit>().reloadData();
                    },
                    child: Text('Press me!'),
                  );
                } else if (state is IntensityFetchSuccess) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Returned Data'),
                      Text('Forecast From: ${state.intensity.from}'),
                      Text('Forecast To: ${state.intensity.to}'),
                      Text('Forecast intensity: ${state.intensity.forecast}'),
                      Text('Actual intensity: ${state.intensity.actual}'),
                      Text('Index: ${state.intensity.intensityIndexAsString}'),
                    ],
                  );
                }
                return null;
              })
            ],
          ),
        ),
      ),
    );
  }
}
