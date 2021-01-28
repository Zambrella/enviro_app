import 'package:enviro_app/constants/ui_constants.dart';
import 'package:enviro_app/ui/global_widgets/primary_button.dart';
import 'package:flutter/material.dart';

class AddReminderModal extends StatefulWidget {
  @override
  _AddReminderModalState createState() => _AddReminderModalState();
}

class _AddReminderModalState extends State<AddReminderModal> {
  TextEditingController _reminderNameController;

  @override
  void initState() {
    super.initState();
    _reminderNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _reminderNameController.dispose();
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
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        hintText: 'Select due date',
                      ),
                      onTap: () {
                        // Open datetime picker
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        labelText: 'Due Time',
                        hintText: 'Select due time',
                      ),
                      onTap: () {
                        // Open datetime picker
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: textTheme.button.copyWith(color: kErrorColor),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PrimaryButton(
                        label: 'Add',
                        active: true,
                        function: () {
                          print('Add');
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
