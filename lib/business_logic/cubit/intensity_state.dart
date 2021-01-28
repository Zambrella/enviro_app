part of 'intensity_cubit.dart';

@immutable
abstract class IntensityState {}

class IntensityInitial extends IntensityState {}

class IntensityFetchSuccess extends IntensityState {
  final Intensity intensity;
  final IntensityStatistics intensityStatistics;
  final List<TimeSection> timeSelection;
  IntensityFetchSuccess(
      {this.intensity, this.intensityStatistics, this.timeSelection});
}

class IntensitySpecificTimePeriodSuccess extends IntensityState {
  final List<Intensity> intensities;
  IntensitySpecificTimePeriodSuccess({this.intensities});
}

class IntensityFetchInProgress extends IntensityState {}
