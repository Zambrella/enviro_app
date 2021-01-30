part of 'intensity_cubit.dart';

@immutable
abstract class IntensityState {}

class IntensityInitial extends IntensityState {}

class IntensityFetchSuccess extends IntensityState {
  final Intensity intensity;
  final IntensityStatistics intensityStatistics;
  final List<TimeSection> timeSelection;
  final List<Reminder> reminders;
  IntensityFetchSuccess(
      {this.intensity,
      this.intensityStatistics,
      this.timeSelection,
      this.reminders});
}

class IntensitySpecificTimePeriodSuccess extends IntensityState {
  final Intensity intensity;
  IntensitySpecificTimePeriodSuccess({this.intensity});
}

class IntensityFetchInProgress extends IntensityState {}
