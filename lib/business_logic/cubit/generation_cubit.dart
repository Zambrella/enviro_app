import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/generation_repository.dart';

part 'generation_state.dart';

class GenerationCubit extends Cubit<GenerationState> {
  final GenerationRepository repo;
  GenerationCubit({this.repo}) : super(GenerationInitial());

  void loadGenerationData(
      {@required DateTime from, @required DateTime to}) async {
    emit(GenerationFetchInProgress());
    final generationMix =
        await repo.getAverageGenerationMix(from: from, to: to);
    emit(GenerationFetchSuccess(generationInfo: generationMix));
  }
}
