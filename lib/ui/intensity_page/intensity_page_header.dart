import 'package:enviro_app/business_logic/cubits/cubit/intensity_cubit.dart';
import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntensityPageHeader extends StatefulWidget {
  @override
  _IntensityPageHeaderState createState() => _IntensityPageHeaderState();
}

class _IntensityPageHeaderState extends State<IntensityPageHeader> {
  @override
  void initState() {
    super.initState();
    context.read<IntensityCubit>().loadNationalIntensityData();
  }

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
            BlocBuilder<IntensityCubit, IntensityState>(
              builder: (context, state) {
                if (state is IntensityFetchSuccess) {
                  return _CustomTextWidget(value: state.intensity.forecast);
                } else
                  return _CustomTextWidget(value: 0);
              },
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

class _CustomTextWidget extends StatelessWidget {
  final int value;
  _CustomTextWidget({this.value});
  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      style: Theme.of(context).textTheme.headline4.copyWith(
            color: UIFunctions.getColor(value),
            height: 1.0,
          ),
    );
  }
}
// todo: create animation for number counting up from 0