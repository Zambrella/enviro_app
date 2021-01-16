import 'package:enviro_app/business_logic/cubits/cubit/intensity_cubit.dart';
import 'package:enviro_app/constants/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntensityPageStats extends StatefulWidget {
  @override
  _IntensityPageStatsState createState() => _IntensityPageStatsState();
}

class _IntensityPageStatsState extends State<IntensityPageStats> {
  @override
  void initState() {
    super.initState();
    context.read<IntensityCubit>().loadNationalIntensityData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<IntensityCubit, IntensityState>(
        builder: (context, state) {
          if (state is IntensityFetchSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SingleStatistic(
                  value: state.intensityStatistics.average,
                  label: 'average',
                ),
                SingleStatistic(
                  value: state.intensityStatistics.max,
                  label: 'max',
                ),
                SingleStatistic(
                  value: state.intensityStatistics.min,
                  label: 'min',
                ),
              ],
            );
          } else {
            return Container();
          }
        },
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
