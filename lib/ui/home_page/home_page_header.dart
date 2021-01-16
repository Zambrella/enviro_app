import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
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
              '284',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: kWarningColor,
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
