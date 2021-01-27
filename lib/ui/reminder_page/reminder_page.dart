import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/ui/global_widgets/primary_button.dart';
import 'package:enviro_app/ui/reminder_page/empty_reminders.dart';
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
      // So that the button can position itself at the bottom of the screen
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<RemindersCubit, RemindersState>(
            builder: (context, state) {
              if (state is RemindersUpdated) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
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
                return EmptyReminders();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PrimaryButton(
                label: 'Add Reminder',
                active: true,
                function: () {
                  context
                      .read<RemindersCubit>()
                      .addNewReminder(Reminder(name: 'Turn on dishwasher'));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
