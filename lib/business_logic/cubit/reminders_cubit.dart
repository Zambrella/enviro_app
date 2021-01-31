import 'package:bloc/bloc.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/data/repositories/reminder_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;

part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  ReminderRepository repo;
  RemindersCubit({this.repo}) : super(RemindersInitial());

  // Reminder notification setup
  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          '1', 'Reminders', 'All reminder based notifications',
          importance: Importance.max, priority: Priority.high);

  static const IOSNotificationDetails iosNotificationDetails =
      IOSNotificationDetails();

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosNotificationDetails,
  );

  void getReminders() {
    List<Reminder> reminders = repo.getAllReminders();
    if (reminders.isNotEmpty) {
      reminders.sort((a, b) => a.dueAt.compareTo(b.dueAt));
      emit(RemindersUpdated(
        reminders: reminders,
      ));
    } else {
      emit(RemindersEmpty());
    }
  }

  void addNewReminder(Reminder reminder) {
    repo.addReminder(reminder);
    setNotificationReminder(reminder);
    // Need to notify the UI that a new one has been added
    // Probably a neater way of doing this
    getReminders();
  }

  void deleteReminder(int index, Reminder reminder) {
    repo.deleteReminder(index);
    deleteNotificationReminder(reminder);
    getReminders();
  }

  Future<void> setNotificationReminder(Reminder reminder) async {
    await FlutterLocalNotificationsPlugin().zonedSchedule(
      reminder.uid,
      reminder.name,
      'You have a reminder',
      tz.TZDateTime.utc(reminder.dueAt.year, reminder.dueAt.month,
          reminder.dueAt.day, reminder.dueAt.hour, reminder.dueAt.minute),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> deleteNotificationReminder(Reminder reminder) async {
    await FlutterLocalNotificationsPlugin().cancel(reminder.uid);
  }
}
