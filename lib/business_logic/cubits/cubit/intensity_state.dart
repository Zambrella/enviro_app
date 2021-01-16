part of 'intensity_cubit.dart';

@immutable
abstract class IntensityState {}

class IntensityInitial extends IntensityState {}

class IntensityFetchSuccess extends IntensityState {
  final Intensity intensity;
  final IntensityStatistics intensityStatistics;
  IntensityFetchSuccess({this.intensity, this.intensityStatistics});
}

class IntensityFetchInProgress extends IntensityState {}
