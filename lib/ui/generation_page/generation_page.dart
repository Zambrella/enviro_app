import 'package:enviro_app/business_logic/cubits/cubit/generation_cubit.dart';
import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GenerationPage extends StatefulWidget {
  @override
  _GenerationPageState createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  @override
  void initState() {
    super.initState();
    context.read<GenerationCubit>().loadGenerationData(
        from: DateTime.now().subtract(Duration(days: 7)), to: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenerationCubit, GenerationState>(
      builder: (context, state) {
        if (state is GenerationFetchInProgress) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GenerationFetchSuccess) {
          print(state.generationInfo);
          List<PieData> data = [];
          state.generationInfo.forEach(
              (key, value) => data.add(PieData(title: key, percentage: value)));

          List<charts.Series<PieData, String>> series = [
            charts.Series(
              id: 'Generation Mix',
              data: data,
              domainFn: (PieData pieData, _) => pieData.title,
              measureFn: (PieData pieData, _) => pieData.percentage,
              labelAccessorFn: (PieData pieData, _) => '${pieData.title}',
              colorFn: (PieData piedata, _) =>
                  charts.ColorUtil.fromDartColor(piedata.color),
            )
          ];

          return Container(
            child: charts.PieChart(
              series,
              animate: true,
              defaultRenderer: charts.ArcRendererConfig(
                arcWidth: 80,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                    leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                        thickness: 1,
                        length: 20,
                        color: charts.ColorUtil.fromDartColor(
                            kSecondaryTextColor)),
                    labelPosition: charts.ArcLabelPosition.auto,
                    insideLabelStyleSpec: charts.TextStyleSpec(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      color: charts.ColorUtil.fromDartColor(Colors.white),
                      // Font weight not supported at the moment
                    ),
                    outsideLabelStyleSpec: charts.TextStyleSpec(
                      fontFamily: 'Lato',
                      fontSize: 12,
                      color: charts.ColorUtil.fromDartColor(kPrimaryTextColor),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class PieData {
  final String title;
  final double percentage;
  Color color;
  // Todo: Add icon
  PieData({this.title, this.percentage}) {
    switch (this.title) {
      case ('biomass'):
        this.color = kVeryLow;
        break;
      case ('coal'):
        this.color = kVeryHigh;
        break;
      case ('imports'):
        this.color = kModerate;
        break;
      case ('gas'):
        this.color = kVeryHigh;
        break;
      case ('nuclear'):
        this.color = kVeryLow;
        break;
      case ('other'):
        this.color = kModerate;
        break;
      case ('hydro'):
        this.color = kVeryLow;
        break;
      case ('solar'):
        this.color = kVeryLow;
        break;
      case ('wind'):
        this.color = kVeryLow;
        break;
    }
  }
}
