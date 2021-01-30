import 'package:enviro_app/constants/functions.dart';
import 'package:enviro_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 8.0),
            Text(
              '''
Electricity in the UK is generated through a number of different sources, each with their own carbon impact. During times of high usage, the demand on non-renewable sources goes up and with it, the environmental impact. However, if it's particularly windy or sunny, energy can be generated primarily from these renewable sources.
''',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            FuelTypeIntensityTable(),
            SizedBox(height: 8.0),
            Text(
              '''
A team was put together by the National Grid ESO in partnership with Environmental Defense Fund Europe, University of Oxford Department of Computer Science and WWF to take all these factors and create a prediction model.

By using machine learning, sophisticated power system modelling and the weather forecast, it has been possible to create a highly accurate 96-hour prediction for the carbon cost of electricity. This has been made publically available through an API.

By using this information, I have created this app to show the best times to use electricity.
''',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Row(
              children: [
                Text('For more information ',
                    style: Theme.of(context).textTheme.bodyText1),
                GestureDetector(
                  onTap: () async {
                    launch('https://carbonintensity.org.uk');
                  },
                  child: Text('click here',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline)),
                ),
                Text('.', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
                onTap: () async {
                  launch('https://www.nationalgrideso.com');
                },
                child:
                    Image(image: AssetImage('assets/images/NGESO_logo.webp'))),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      launch('https://www.edf.org/europe');
                    },
                    child: Image(
                      image: AssetImage('assets/images/EDF_logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      launch('http://www.cs.ox.ac.uk/');
                    },
                    child: Image(
                      image: AssetImage('assets/images/Oxford_logo.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  launch('https://www.wwf.org.uk/');
                },
                child: Image.asset(
                  'assets/images/WWF_logo.png',
                  height: 150,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FuelTypeIntensityTable extends StatelessWidget {
  final columns = const <DataColumn>[
    DataColumn(label: Text('Fuel Type')),
    DataColumn(label: Text('Carbon Intensity\n(gCO₂/KWh)')),
  ];

  // Easier to edit the data when it's in a map
  final rows = const <String, int>{
    'Biomass': 120,
    'Coal': 937,
    'Gas (Combined Cycle)': 394,
    'Gas (Open Cycle)': 951,
    'Hydro': 0,
    'Nuclear': 0,
    'Oil': 935,
    'Other': 300,
    'Pumped Storage': 0,
    'Solar': 0,
    'Wind': 0,
  };

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 45,
      dataRowHeight: 30,
      columns: columns,
      rows: rows.entries
          .map(
            (e) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(e.key),
                ),
                DataCell(
                  Text(
                    e.value.toString(),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: UIFunctions.getColor(e.value),
                        ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
