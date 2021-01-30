import 'package:enviro_app/business_logic/cubit/reminders_cubit.dart';
import 'package:enviro_app/data/repositories/reminder_repository.dart';
import 'package:enviro_app/ui/theme/input_decoration_theme.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'business_logic/cubit/generation_cubit.dart';
import 'constants/ui_constants.dart';
import 'data/models/reminder.dart';
import 'data/repositories/generation_repository.dart';
import 'data/repositories/intensity_repository.dart';
import 'ui/theme/text_theme.dart';

import 'business_logic/cubit/intensity_cubit.dart';
import 'ui/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Reminder>(ReminderAdapter());
  // Don't have to pass this as an object as it be accessed by name later
  // This just opens it so it can be accessed later
  await Hive.openBox<Reminder>('reminders');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final intensityRepo = IntensityRepository();
  final generationRepo = GenerationRepository();
  final reminderRepo = ReminderRepository();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IntensityCubit(
            repo: intensityRepo,
            reminderRepo: reminderRepo,
          ),
        ),
        BlocProvider(
          create: (context) => GenerationCubit(
            repo: generationRepo,
          ),
        ),
        BlocProvider(
          create: (context) => RemindersCubit(
            repo: reminderRepo,
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: kPrimaryColor,
          accentColor: kPrimaryColor,
          textTheme: kTextTheme,
          inputDecorationTheme: kInputDecorationTheme,
          colorScheme: ColorScheme.light(primary: kPrimaryColor),
          // timePickerTheme: TimePickerThemeData(),
        ),
        home: HomePage(),
      ),
    );
  }
}
