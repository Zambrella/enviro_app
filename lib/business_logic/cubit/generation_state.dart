part of 'generation_cubit.dart';

@immutable
abstract class GenerationState {}

class GenerationInitial extends GenerationState {}

class GenerationFetchSuccess extends GenerationState {
  final Map<String, double> generationInfo;
  GenerationFetchSuccess({this.generationInfo});
}

class GenerationFetchInProgress extends GenerationState {}
