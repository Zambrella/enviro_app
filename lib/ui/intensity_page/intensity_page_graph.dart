import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/ui/reminder_page/add_reminder_modal.dart';

import '../../business_logic/cubit/intensity_cubit.dart';
import '../../constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class IntensityPageGraph extends StatefulWidget {
  @override
  _IntensityPageGraphState createState() => _IntensityPageGraphState();
}

class _IntensityPageGraphState extends State<IntensityPageGraph> {
  static const _totalHeight = 350.0;
  static const _barWidth = 32.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _totalHeight,
      child: BlocBuilder<IntensityCubit, IntensityState>(
        builder: (context, state) {
          if (state is IntensityFetchSuccess) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.timeSelection.length,
              itemBuilder: (context, index) {
                // Helper function to check whether a time section has a reminder
                bool hasReminder() {
                  int hasReminder = 0;

                  // Iterate through each reminder to see if it falls within a given time selection
                  for (Reminder reminder in state.reminders) {
                    if (reminder.dueAt
                            .isAfter(state.timeSelection[index].from) &&
                        reminder.dueAt
                            .isBefore(state.timeSelection[index].to)) {
                      hasReminder++;
                    }
                  }

                  // If the value has been increased then it must have a reminder
                  if (hasReminder > 0) {
                    return true;
                  } else {
                    return false;
                  }
                }

                return GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddReminderModal(
                            startDateTime: state.timeSelection[index].from,
                          );
                        });
                  },
                  child: GraphBar(
                    barHeight: _totalHeight,
                    barWidth: _barWidth,
                    dateTime: state.timeSelection[index].from,
                    primaryBarHeight: _totalHeight *
                        (state.timeSelection[index].intensityAverage / 600),
                    hasReminder: hasReminder(),
                    intensity: state.timeSelection[index].intensityAverage,
                  ),
                );
              },
            );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class GraphBar extends StatefulWidget {
  final double barHeight;
  final double barWidth;
  final DateTime dateTime;
  final double primaryBarHeight;
  final bool hasReminder;
  final int intensity;

  GraphBar({
    @required this.barHeight,
    @required this.barWidth,
    @required this.dateTime,
    @required this.primaryBarHeight,
    @required this.hasReminder,
    @required this.intensity,
  });

  @override
  _GraphBarState createState() => _GraphBarState();
}

class _GraphBarState extends State<GraphBar> {
  final double hourTextHeight = 25;

  final double dayTextHeight = 20;

  // Initial value for the bar height so it can animate from 0
  double _barHeight = 0;

  @override
  void initState() {
    super.initState();
    // Need to wait until the bars are built before updating the value
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _barHeight = widget.primaryBarHeight;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: widget.barHeight - hourTextHeight - dayTextHeight,
                width: widget.barWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                      Color(0xffD6D6D6).withOpacity(0.0),
                      Color(0xffD6D6D6),
                      Color(0xffD6D6D6).withOpacity(0.80),
                      Color(0xffD6D6D6).withOpacity(0.0),
                    ],
                    stops: [
                      0.0,
                      0.1,
                      0.8,
                      1.0,
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                height: _barHeight,
                width: widget.barWidth,
                decoration: BoxDecoration(
                  color: UIFunctions.getColor(widget.intensity),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                child: widget.hasReminder
                    ? Container(
                        child: Icon(Icons.alarm),
                      )
                    : Container(),
              )
            ],
          ),
        ),
        Container(
          height: hourTextHeight,
          child: Center(
            child: Text(
              DateFormat.Hm().format(widget.dateTime),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Container(
          height: dayTextHeight,
          // Only show day if it's a new day
          child: widget.dateTime.hour == 0 || widget.dateTime.hour == 1
              ? Text(DateFormat.E().format(widget.dateTime))
              : Text(' '),
        ),
      ],
    );
  }
}
