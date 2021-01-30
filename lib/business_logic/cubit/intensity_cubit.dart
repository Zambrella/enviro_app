import 'package:bloc/bloc.dart';
import 'package:enviro_app/data/models/reminder.dart';
import 'package:enviro_app/data/repositories/reminder_repository.dart';
import '../../data/models/intensity.dart';
import '../../data/models/statistics.dart';
import '../../data/models/time_section.dart';
import '../../data/repositories/intensity_repository.dart';
import 'package:meta/meta.dart';

part 'intensity_state.dart';

class IntensityCubit extends Cubit<IntensityState> {
  final IntensityRepository repo;
  final ReminderRepository reminderRepo;
  IntensityCubit({@required this.repo, this.reminderRepo})
      : super(IntensityInitial());

  void loadNationalIntensityData() async {
    emit(IntensityFetchInProgress());
    final intensity = await repo.getNationalIntesity();
    final intensityStats = await repo.get48hrNationalStatistics();
    final timeSelection = await repo.getTimeSections();
    final reminders = reminderRepo.getAllReminders();
    emit(
      IntensityFetchSuccess(
        intensity: intensity,
        intensityStatistics: intensityStats,
        timeSelection: timeSelection,
        reminders: reminders,
      ),
    );
  }

  void loadSpecificTimeIntensityData(DateTime dateTime) async {
    emit(IntensityFetchInProgress());
    final Intensity intensitiy =
        await repo.getNationalIntensityForReminder(dateTime);
    emit(IntensitySpecificTimePeriodSuccess(intensity: intensitiy));
  }
}
