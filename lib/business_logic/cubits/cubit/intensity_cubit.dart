import 'package:bloc/bloc.dart';
import 'package:enviro_app/data/models/statistics.dart';
import 'package:enviro_app/data/models/time_section.dart';
import '../../../data/models/intensity.dart';
import '../../../data/repositories/intensity_repository.dart';
import 'package:meta/meta.dart';

part 'intensity_state.dart';

class IntensityCubit extends Cubit<IntensityState> {
  final IntensityRepository repo;
  IntensityCubit({@required this.repo}) : super(IntensityInitial());

  void loadNationalIntensityData() async {
    emit(IntensityFetchInProgress());
    final intensity = await repo.getNationalIntesity();
    final intensityStats = await repo.get48hrNationalStatistics();
    final timeSelection = await repo.getTimeSections();
    emit(
      IntensityFetchSuccess(
        intensity: intensity,
        intensityStatistics: intensityStats,
        timeSelection: timeSelection,
      ),
    );
  }
}
