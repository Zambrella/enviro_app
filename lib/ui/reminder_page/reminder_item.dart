import 'package:enviro_app/business_logic/cubit/intensity_cubit.dart';
import 'package:enviro_app/constants/functions.dart';
import 'package:enviro_app/constants/ui_constants.dart';
import 'package:enviro_app/data/models/intensity.dart';
import 'package:enviro_app/data/repositories/intensity_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  // Can definitely do better than this!
  // Maybe a better way would be to get the day in the year and compare (although wouldn't account for reminders 365+ days in the future)
  // Todo: What will happen if it's the 31st and day =+ 1? Also need an option for 'Overdue'
  String _getDay2(DateTime dateTime) {
    var now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return 'Today';
    } else if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day + 1 == now.day) {
      return 'Tomorrow';
    } else {
      // Just show the day of the week
      return DateFormat.E().format(dateTime);
    }
  }

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
                  title ?? 'Oh no it was null',
                  style: textTheme.headline6,
                ),
                Row(
                  children: [
                    Text(
                      '${_getDay2(dueDate)}, ${DateFormat('h:mm a').format(dueDate)}',
                      style: textTheme.bodyText1,
                    ),
                    Visibility(
                        visible: DateTime.now().isAfter(dueDate),
                        child: Text(
                          ' - Overdue',
                          style:
                              textTheme.bodyText1.copyWith(color: kErrorColor),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IntensityData(
                dueDate: dueDate,
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

class IntensityData extends StatefulWidget {
  final DateTime dueDate;
  IntensityData({this.dueDate});
  @override
  _IntensityDataState createState() => _IntensityDataState();
}

class _IntensityDataState extends State<IntensityData> {
  IntensityRepository repo;

  @override
  void initState() {
    super.initState();
    repo = IntensityRepository();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return FutureBuilder(
      future: repo.getNationalIntensityForReminder(widget.dueDate),
      initialData: Intensity(forecast: 0),
      builder: (context, AsyncSnapshot<Intensity> snapshot) {
        return Text(
          snapshot.data.forecast.toString(),
          style: textTheme.headline6.copyWith(
            color: UIFunctions.getColor(snapshot.data.forecast),
          ),
        );
      },
    );
  }
}
