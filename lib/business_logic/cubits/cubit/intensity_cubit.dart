import 'package:bloc/bloc.dart';
import '../../../data/models/intensity.dart';
import '../../../data/repositories/intensity_repository.dart';
import 'package:meta/meta.dart';

part 'intensity_state.dart';

// Incoming event (or in cubit case a function)
// - Get data

// Out going is the state (which is the data)

class IntensityCubit extends Cubit<IntensityState> {
  // instantiate the repo inside this class, although might be better to
  // pass it into the constructor
  final IntensityRepository repo = IntensityRepository();
  IntensityCubit() : super(IntensityInitial());

  void reloadData() async {
    emit(IntensityFetchInProgress());
    final intensity = await repo.getNationalIntesity();
    emit(
      IntensityFetchSuccess(
        intensity: intensity,
      ),
    );
  }
}
