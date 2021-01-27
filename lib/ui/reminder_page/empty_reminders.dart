import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class EmptyReminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No reminders.\nSet yourself a reminder to use energy during the cheapest times.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 28, color: kSecondaryTextColor.withOpacity(0.5)),
          ),
          SizedBox(
            height: 16,
          ),
          Icon(
            Icons.arrow_downward,
            size: 50,
            color: kSecondaryTextColor.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
