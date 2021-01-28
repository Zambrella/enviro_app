import 'package:enviro_app/data/models/reminder.dart';
import 'package:hive/hive.dart';

class ReminderRepository {
  final Box box = Hive.box<Reminder>('reminders');

  ReminderRepository();

  List<Reminder> getAllReminders() {
    List<Reminder> reminders = [];
    if (box.isNotEmpty) {
      reminders = box.values.toList();
    }
    print('Reminder Repository: $reminders');
    return reminders;
  }

  void addReminder(Reminder reminder) {
    // Using .add instead of .put because we don't care about the key
    box.add(reminder);
  }

  void deleteReminder(int index) {
    box.deleteAt(index);
  }
}
