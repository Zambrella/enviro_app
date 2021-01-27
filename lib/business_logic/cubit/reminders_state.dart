part of 'reminders_cubit.dart';

@immutable
abstract class RemindersState {}

class RemindersInitial extends RemindersState {
  final List<Reminder> reminders = [];
}

class RemindersUpdated extends RemindersState {
  final List<Reminder> reminders;
  RemindersUpdated({this.reminders});
}

class RemindersEmpty extends RemindersState {}

class RemindersFetchFailed extends RemindersState {
  final String message;
  RemindersFetchFailed({this.message});
}
