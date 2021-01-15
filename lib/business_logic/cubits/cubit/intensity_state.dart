part of 'intensity_cubit.dart';

@immutable
abstract class IntensityState {}

class IntensityInitial extends IntensityState {}

class IntensityFetchSuccess extends IntensityState {
  final Intensity intensity;
  IntensityFetchSuccess({this.intensity});
}

class IntensityFetchInProgress extends IntensityState {}
