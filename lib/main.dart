import 'package:enviro_app/constants/ui_constants.dart';

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
        textTheme: TextTheme(
          headline4: TextStyle(
            fontFamily: 'Lato',
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: kPrimaryTextColor,
          ),
          headline5: TextStyle(
            fontFamily: 'Lato',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kPrimaryTextColor,
          ),
          headline6: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: kPrimaryTextColor,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kPrimaryTextColor,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Lato',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: kPrimaryTextColor,
          ),
          bodyText2: TextStyle(
            fontFamily: 'Lato',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: kSecondaryTextColor,
          ),
          button: TextStyle(
            fontFamily: 'Lato',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kSecondaryTextColor,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => IntensityCubit(),
        child: HomePage(),
      ),
    );
  }
}
