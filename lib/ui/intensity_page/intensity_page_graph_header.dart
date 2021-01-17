import 'package:flutter/material.dart';

class IntensityPageGraphHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        'Next 48 hrs',
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
