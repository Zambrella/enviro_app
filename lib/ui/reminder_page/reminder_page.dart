import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  void initState() {
    super.initState();
    context.read<RemindersCubit>().getReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<RemindersCubit, RemindersState>(
            builder: (context, state) {
              if (state is RemindersUpdated) {
                return ListView.builder(
                  itemCount: state.reminders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          context.read<RemindersCubit>().deleteReminder(index);
                        },
                        child: Text(state.reminders[index].name ?? 'No Name'));
                  },
                );
              } else if (state is RemindersEmpty) {
                return Text('No reminders. All more below');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          RaisedButton(
            onPressed: () {
              context
                  .read<RemindersCubit>()
                  .addNewReminder(Reminder(name: 'Reminder 2'));
              // context.read<RemindersCubit>().getReminders();
            },
            child: Text('Add reminder'),
          ),
        ],
      ),
    );
  }
}
