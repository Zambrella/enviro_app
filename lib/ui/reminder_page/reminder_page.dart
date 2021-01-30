import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/constants/ui_constants.dart';
import 'package:enviro_app/ui/reminder_page/add_reminder_modal.dart';
import 'package:enviro_app/ui/reminder_page/empty_reminders.dart';
import 'package:enviro_app/ui/reminder_page/reminder_item.dart';
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
    // context.read<IntensityCubit>().loadSpecificTimeIntensityData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height set to infinite so that the button can position itself at the bottom of the screen
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
                    // Might look better to have this as a Sliver bar so it scrolls as well
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
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomFAB(),
            ),
          )
        ],
      ),
    );
  }
}

class CustomFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AddReminderModal();
            });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kSecondaryColor,
          boxShadow: [
            BoxShadow(
              color: kSecondaryColor.withOpacity(0.40),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
