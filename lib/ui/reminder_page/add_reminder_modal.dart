import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/constants/ui_constants.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/ui/global_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReminderModal extends StatefulWidget {
  final DateTime startDateTime;
  AddReminderModal({this.startDateTime});
  @override
  _AddReminderModalState createState() => _AddReminderModalState();
}

class _AddReminderModalState extends State<AddReminderModal> {
  TextEditingController _reminderNameController;
  TextEditingController _dueDateController;
  TextEditingController _dueTimeController;

  // Variable to hold the selected reminder datetime
  var _dueDate;

  @override
  void initState() {
    super.initState();
    // Set default value to now
    //? There might be a better way to do this, potentially using named constructor (default constructor takes now, named constructor takes a datetime)
    _dueDate = widget.startDateTime ?? DateTime.now();
    // Initialise controllers
    _reminderNameController = TextEditingController();
    _dueDateController = TextEditingController();
    _dueTimeController = TextEditingController();
    // Set the default values of controllers
    _dueDateController.text = dateTimeToDate(_dueDate);
    _dueTimeController.text = dateTimeToTime(_dueDate);
  }

  @override
  void dispose() {
    super.dispose();
    _reminderNameController.dispose();
    _dueDateController.dispose();
    _dueTimeController.dispose();
  }

  String dateTimeToDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d').format(dateTime);
  }

  String dateTimeToTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Dialog(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Reminder',
                style: textTheme.headline5,
              ),
              TextField(
                cursorColor: kPrimaryColor,
                controller: _reminderNameController,
                decoration: InputDecoration(
                  labelText: 'Reminder',
                  hintText: 'Enter reminder name',
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: _dueDateController,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Select due date',
                      ),
                      onTap: () async {
                        var _selectedDate = await showDatePicker(
                          context: context,
                          initialDate: _dueDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (_selectedDate != null) {
                          setState(() {
                            _dueDate = _selectedDate;
                            _dueDateController.text = dateTimeToDate(_dueDate);
                            _dueTimeController.text = dateTimeToTime(_dueDate);
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      cursorColor: kPrimaryColor,
                      controller: _dueTimeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Select due time',
                      ),
                      onTap: () async {
                        var _selectedTimeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(_dueDate));
                        if (_selectedTimeOfDay != null) {
                          setState(() {
                            _dueDate = DateTime(
                              _dueDate.year,
                              _dueDate.month,
                              _dueDate.day,
                              _selectedTimeOfDay.hour,
                              _selectedTimeOfDay.minute,
                            );
                            _dueDateController.text = dateTimeToDate(_dueDate);
                            _dueTimeController.text = dateTimeToTime(_dueDate);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style:
                                textTheme.button.copyWith(color: kErrorColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PrimaryButton(
                        label: 'Add',
                        active: true,
                        function: () {
                          context.read<RemindersCubit>().addNewReminder(
                                Reminder(
                                    name: _reminderNameController.text,
                                    createdAt: DateTime.now(),
                                    dueAt: _dueDate),
                              );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
