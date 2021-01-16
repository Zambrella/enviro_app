import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';

class IntensityPageHeader extends StatelessWidget {
  final int value = 284;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Text(
              'Carbon Intensity',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: UIFunctions.getColor(value),
                    height: 1.0,
                  ),
            ),
            Text(
              'gCO₂/KWh',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 10,
                    // Changing height so that the text is closer to the text above
                    height: 0.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
