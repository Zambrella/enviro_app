import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:enviro_app/business_logic/cubits/cubit/generation_cubit.dart';
import 'package:enviro_app/constants/ui_constants.dart';

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
          // Convert the state data into a class that can be used with the Pie Chart
          // and generally make it easier to handle
          List<PieData> data = [];
          state.generationInfo.forEach(
              (key, value) => data.add(PieData(title: key, percentage: value)));
          // Create a sorted list of the above data for use in the key
          List<PieData> sortedList = [...data];
          sortedList.sort((a, b) => b.percentage.compareTo(a.percentage));

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      context.read<GenerationCubit>().loadGenerationData(
                          from: DateTime.now().subtract(Duration(days: 1)),
                          to: DateTime.now());
                    },
                    child: Text('Past Day'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      context.read<GenerationCubit>().loadGenerationData(
                          from: DateTime.now().subtract(Duration(days: 7)),
                          to: DateTime.now());
                    },
                    child: Text('Past 7 Days'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      context.read<GenerationCubit>().loadGenerationData(
                          from: DateTime.now().subtract(Duration(days: 28)),
                          to: DateTime.now());
                    },
                    child: Text('Past 28 Days'),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: charts.PieChart(
                    series,
                    animate: true,
                    defaultRenderer: charts.ArcRendererConfig(
                      arcWidth: 80,
                      arcRendererDecorators: [
                        charts.ArcLabelDecorator(
                          leaderLineStyleSpec:
                              charts.ArcLabelLeaderLineStyleSpec(
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
                            color: charts.ColorUtil.fromDartColor(
                                kPrimaryTextColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 8,
                  children: List.generate(
                    sortedList.length,
                    (index) => IndexItem(
                      icon: sortedList[index].icon,
                      label: sortedList[index].title,
                      value: sortedList[index].percentage,
                      color: sortedList[index].color,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

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
        Text('$label - '),
        Text('${value.toStringAsFixed(1)}%'),
      ],
    );
  }
}

class PieData {
  final String title;
  final double percentage;
  Color color;
  IconData icon;
  PieData({this.title, this.percentage}) {
    switch (this.title) {
      case ('biomass'):
        this.color = kVeryLow;
        this.icon = Icons.eco;
        break;
      case ('coal'):
        this.color = kVeryHigh;
        this.icon = Icons.whatshot;
        break;
      case ('imports'):
        this.color = kModerate;
        this.icon = Icons.local_shipping;
        break;
      case ('gas'):
        this.color = kVeryHigh;
        this.icon = Icons.local_gas_station;
        break;
      case ('nuclear'):
        this.color = kVeryLow;
        this.icon = Icons.science;
        break;
      case ('other'):
        this.color = kModerate;
        this.icon = Icons.battery_unknown;
        break;
      case ('hydro'):
        this.color = kVeryLow;
        this.icon = Icons.waves;
        break;
      case ('solar'):
        this.color = kVeryLow;
        this.icon = Icons.wb_sunny;
        break;
      case ('wind'):
        this.color = kVeryLow;
        this.icon = Icons.cloud;
        break;
    }
  }
}
