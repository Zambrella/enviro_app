import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class IntensityPageGraph extends StatelessWidget {
  static const _totalHeight = 350.0;
  static const _barWidth = 32.0;
  final List<GraphBar> _backgroundBars = [
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now(),
      primaryBarHeight: 200,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 2)),
      primaryBarHeight: 100,
      hasReminder: true,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 4)),
      primaryBarHeight: 50,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 6)),
      primaryBarHeight: 230,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 8)),
      primaryBarHeight: 30,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 10)),
      primaryBarHeight: 10,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 12)),
      primaryBarHeight: 215,
      hasReminder: true,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 14)),
      primaryBarHeight: 123,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 16)),
      primaryBarHeight: 40,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 18)),
      primaryBarHeight: 70,
      hasReminder: false,
    ),
    GraphBar(
      barHeight: _totalHeight,
      barWidth: _barWidth,
      dateTime: DateTime.now().add(Duration(hours: 20)),
      primaryBarHeight: 100,
      hasReminder: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _totalHeight,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _backgroundBars.length,
        itemBuilder: (context, index) {
          return _backgroundBars[index];
        },
      ),
    );
  }
}

class GraphBar extends StatelessWidget {
  final double barHeight;
  final double barWidth;
  final DateTime dateTime;
  final double primaryBarHeight;
  final bool hasReminder;
  final double hourTextHeight = 25;
  final double dayTextHeight = 20;
  GraphBar({
    @required this.barHeight,
    @required this.barWidth,
    @required this.dateTime,
    @required this.primaryBarHeight,
    @required this.hasReminder,
  });
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
                height: barHeight - hourTextHeight - dayTextHeight,
                width: barWidth,
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
              Container(
                height: primaryBarHeight,
                width: barWidth,
                decoration: BoxDecoration(
                  color: kWarningColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
              Positioned(
                top: 4,
                child: hasReminder
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
              '${dateTime.hour}:${dateTime.minute}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Container(
          height: dayTextHeight,
          // Only show day if it's a new day
          child: dateTime.hour == 0 ? Text('${dateTime.day}') : Text(' '),
        ),
      ],
    );
  }
}
