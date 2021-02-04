import '../../business_logic/cubit/intensity_cubit.dart';
import '../../constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class IntensityPageStats extends StatefulWidget {
  final ScrollController scrollController;
  IntensityPageStats({this.scrollController});
  @override
  _IntensityPageStatsState createState() => _IntensityPageStatsState();
}

class _IntensityPageStatsState extends State<IntensityPageStats>
    with TickerProviderStateMixin {
  AnimationController _textAnimationController;
  IntTween _intTweenAverage;
  IntTween _intTweenMax;
  IntTween _intTweenMin;
  Animation<int> _averageAnimation;
  Animation<int> _maxAnimation;
  Animation<int> _minAnimation;
  int _indexOfMinTimeSection;
  int _indexOfMaxTimeSection;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _intTweenAverage = IntTween(begin: 0, end: 1);
    _intTweenMax = IntTween(begin: 0, end: 1);
    _intTweenMin = IntTween(begin: 0, end: 1);
    _averageAnimation = _intTweenAverage.animate(_textAnimationController);
    _maxAnimation = _intTweenMax.animate(_textAnimationController);
    _minAnimation = _intTweenMin.animate(_textAnimationController);
    _indexOfMinTimeSection = 1;
    _indexOfMaxTimeSection = 1;
  }

  @override
  void dispose() {
    super.dispose();
    _textAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntensityCubit, IntensityState>(
      listener: (context, state) {
        if (state is IntensityFetchSuccess) {
          // Set the end values of tween animation to be values from stats api call
          _intTweenAverage.end = state.intensityStatistics.average;
          _intTweenMax.end = state.intensityStatistics.max;
          _intTweenMin.end = state.intensityStatistics.min;

          // Set the animation rolling after the data has loaded
          _textAnimationController.forward();

          // Get the index of min average
          // Get the list of averages for each time selection
          var averages =
              state.timeSelection.map((e) => e.intensityAverage).toList();
          // Get the index where the list of time selections matches the min
          _indexOfMinTimeSection = state.timeSelection.indexWhere((element) {
            return element.intensityAverage == averages.reduce(min);
          });
          // Get the index where the list of time selections matches the max
          _indexOfMaxTimeSection = state.timeSelection.indexWhere((element) {
            return element.intensityAverage == averages.reduce(max);
          });
        }
      },
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedBuilder(
              animation: _averageAnimation,
              builder: (context, child) {
                return SingleStatistic(
                  value: _averageAnimation.value,
                  label: 'average',
                );
              },
            ),
            AnimatedBuilder(
              animation: _maxAnimation,
              builder: (context, child) {
                return InkWell(
                  onTap: () => widget.scrollController.animateTo(
                      _indexOfMaxTimeSection * 64.0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOutBack),
                  child: SingleStatistic(
                    value: _maxAnimation.value,
                    label: 'max',
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _minAnimation,
              builder: (context, child) {
                return InkWell(
                  onTap: () => widget.scrollController.animateTo(
                      _indexOfMinTimeSection * 64.0,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeIn),
                  child: SingleStatistic(
                    value: _minAnimation.value,
                    label: 'min',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SingleStatistic extends StatelessWidget {
  final int value;
  final String label;
  SingleStatistic({@required this.value, @required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(
        // Center required to get them to be in the middle of the flexible space
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: UIFunctions.getColor(value)),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
