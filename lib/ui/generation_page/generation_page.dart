import 'package:charts_flutter/flutter.dart' as charts;
import 'index_item.dart';
import 'pie_data_model.dart';
import 'select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/generation_cubit.dart';
import '../../constants/ui_constants.dart';

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

  // Index to hold what date period is selected
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectButton(
              buttonText: 'Past Day',
              isSelected: _selectedIndex == 0,
              buttonFunction: () {
                setState(() {
                  _selectedIndex = 0;
                });
                context.read<GenerationCubit>().loadGenerationData(
                    from: DateTime.now().subtract(Duration(days: 1)),
                    to: DateTime.now());
              },
            ),
            SelectButton(
              buttonText: 'Past 7 Days',
              isSelected: _selectedIndex == 1,
              buttonFunction: () {
                setState(() {
                  _selectedIndex = 1;
                });
                context.read<GenerationCubit>().loadGenerationData(
                    from: DateTime.now().subtract(Duration(days: 7)),
                    to: DateTime.now());
              },
            ),
            SelectButton(
              buttonText: 'Past 28 Days',
              isSelected: _selectedIndex == 2,
              buttonFunction: () {
                setState(() {
                  _selectedIndex = 2;
                });
                context.read<GenerationCubit>().loadGenerationData(
                    from: DateTime.now().subtract(Duration(days: 28)),
                    to: DateTime.now());
              },
            ),
          ],
        ),
        BlocBuilder<GenerationCubit, GenerationState>(
          builder: (context, state) {
            if (state is GenerationFetchInProgress) {
              return Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (state is GenerationFetchSuccess) {
              print(state.generationInfo);
              // Convert the state data into a class that can be used with the Pie Chart
              // and generally make it easier to handle
              List<PieData> data = [];
              state.generationInfo.forEach((key, value) =>
                  data.add(PieData(title: key, percentage: value)));

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

              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
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
              );
            } else {
              return Container();
            }
          },
        ),
        BlocBuilder<GenerationCubit, GenerationState>(
          builder: (context, state) {
            if (state is GenerationFetchSuccess) {
              // Convert the state data into a class that can be used with the Pie Chart
              // and generally make it easier to handle
              List<PieData> data = [];
              state.generationInfo.forEach((key, value) =>
                  data.add(PieData(title: key, percentage: value)));
              // Create a sorted list of the above data for use in the key
              List<PieData> sortedList = [...data];
              sortedList.sort((a, b) => b.percentage.compareTo(a.percentage));

              return Center(
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
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
