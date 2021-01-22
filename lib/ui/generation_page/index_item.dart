import 'package:flutter/material.dart';

class IndexItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double value;
  IndexItem(
      {@required this.icon,
      @required this.label,
      @required this.value,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          '$label - ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${value.toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
