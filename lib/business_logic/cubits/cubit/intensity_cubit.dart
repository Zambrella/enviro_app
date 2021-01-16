import 'package:bloc/bloc.dart';
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
    emit(
      IntensityFetchSuccess(
        intensity: intensity,
      ),
    );
  }
}
