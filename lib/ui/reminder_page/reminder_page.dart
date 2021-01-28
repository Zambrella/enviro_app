import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/ui/global_widgets/primary_button.dart';
import 'package:enviro_app/ui/reminder_page/add_reminder_modal.dart';
import 'package:enviro_app/ui/reminder_page/empty_reminders.dart';
import 'package:enviro_app/ui/reminder_page/reminder_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Reminders',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: state.reminders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12.0),
                            child: ReminderItem(
                              title: state.reminders[index].name,
                              dueDate: state.reminders[index].dueAt,
                              intensity: 201,
                              onTap: () {
                                context
                                    .read<RemindersCubit>()
                                    .deleteReminder(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AddReminderModal();
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
