import 'package:enviro_app/constants/ui_constants.dart';
import 'package:enviro_app/data/repositories/intensity_repository.dart';
import 'package:enviro_app/ui/theme/text_theme.dart';

import 'business_logic/cubits/cubit/intensity_cubit.dart';
import 'ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: kPrimaryColor,
        textTheme: kTextTheme,
      ),
      home: BlocProvider(
        //* Could also load the initial data here: `IntensityCubit()..loadData()`
        create: (context) => IntensityCubit(repo: IntensityRepository())
          ..loadNationalIntensityData(),
        child: HomePage(),
      ),
    );
  }
}
