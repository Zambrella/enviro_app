import 'package:bloc/bloc.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/data/repositories/reminder_repository.dart';
import 'package:meta/meta.dart';

part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  ReminderRepository repo;
  RemindersCubit({this.repo}) : super(RemindersInitial());

  void getReminders() {
    List<Reminder> reminders = repo.getAllReminders();
    if (reminders.isNotEmpty) {
      emit(RemindersUpdated(
        reminders: reminders,
      ));
    } else {
      emit(RemindersEmpty());
    }
  }

  void addNewReminder(Reminder reminder) {
    repo.addReminder(reminder);
    // Need to notify the UI that a new one has been added
    // Probably a neater way of doing this
    getReminders();
  }

  void deleteReminder(int index) {
    repo.deleteReminder(index);
    getReminders();
  }
}
