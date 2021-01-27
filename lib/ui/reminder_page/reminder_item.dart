import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';

class ReminderItem extends StatelessWidget {
  final String title;
  final DateTime dueDate;
  final int intensity;
  final Function onTap;
  const ReminderItem({
    @required this.title,
    @required this.dueDate,
    @required this.intensity,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.all(1),
            alignment: Alignment.centerLeft,
            icon: Icon(Icons.check_circle_outline),
            iconSize: 30,
            onPressed: onTap,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.headline6,
                ),
                Text(
                  dueDate.toIso8601String(),
                  style: textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                intensity.toString(),
                style: textTheme.headline6.copyWith(
                  color: UIFunctions.getColor(intensity),
                ),
              ),
              Text(
                'gCO₂/KWh',
                style: textTheme.bodyText2.copyWith(
                  fontSize: 10,
                  // Changing height so that the text is closer to the text above
                  height: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
