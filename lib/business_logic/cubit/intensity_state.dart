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

class IntensityFetchInProgress extends IntensityState {}
