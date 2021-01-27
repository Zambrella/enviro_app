import 'business_logic/cubit/generation_cubit.dart';
import 'constants/ui_constants.dart';
import 'data/repositories/generation_repository.dart';
import 'data/repositories/intensity_repository.dart';
import 'ui/theme/text_theme.dart';

import 'business_logic/cubit/intensity_cubit.dart';
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => IntensityCubit(
                repo: IntensityRepository(),
              ),
            ),
            BlocProvider(
              create: (context) => GenerationCubit(
                repo: GenerationRepository(),
              ),
            ),
          ],
          child: HomePage(),
        ));
  }
}
