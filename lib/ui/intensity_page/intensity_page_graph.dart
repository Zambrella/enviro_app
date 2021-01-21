import 'package:enviro_app/business_logic/cubits/cubit/intensity_cubit.dart';
import 'package:enviro_app/constants/functions.dart';
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
                return GraphBar(
                  barHeight: _totalHeight,
                  barWidth: _barWidth,
                  dateTime: state.timeSelection[index].from,
                  primaryBarHeight: _totalHeight *
                      (state.timeSelection[index].intensityAverage / 600),
                  hasReminder: false,
                  intensity: state.timeSelection[index].intensityAverage,
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

class GraphBar extends StatelessWidget {
  final double barHeight;
  final double barWidth;
  final DateTime dateTime;
  final double primaryBarHeight;
  final bool hasReminder;
  final int intensity;
  final double hourTextHeight = 25;
  final double dayTextHeight = 20;
  GraphBar({
    @required this.barHeight,
    @required this.barWidth,
    @required this.dateTime,
    @required this.primaryBarHeight,
    @required this.hasReminder,
    @required this.intensity,
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
                  color: UIFunctions.getColor(intensity),
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
              DateFormat.Hm().format(dateTime),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Container(
          height: dayTextHeight,
          // Only show day if it's a new day
          child: dateTime.hour == 0 || dateTime.hour == 1
              ? Text(DateFormat.E().format(dateTime))
              : Text(' '),
        ),
      ],
    );
  }
}
