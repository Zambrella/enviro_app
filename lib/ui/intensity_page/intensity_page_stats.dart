import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';

class IntensityPageStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleStatistic(
            value: 219,
            label: 'average',
          ),
          SingleStatistic(
            value: 303,
            label: 'max',
          ),
          SingleStatistic(
            value: 103,
            label: 'min',
          ),
        ],
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
    return Column(
      // Center required to get them to be in the middle of the flexible space
      mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
