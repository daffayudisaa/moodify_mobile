import 'package:equatable/equatable.dart';

abstract class RecapState extends Equatable {
  const RecapState();

  @override
  List<Object> get props => [];
}

class RecapInitial extends RecapState {}

class RecapLoading extends RecapState {}

class RecapLoaded extends RecapState {
  final int happy;
  final int sad;
  final int fear;
  final int disgust;
  final int angry;
  final int surprise;
  final int neutral;
  final int total;

  const RecapLoaded({
    required this.happy,
    required this.sad,
    required this.fear,
    required this.disgust,
    required this.angry,
    required this.surprise,
    required this.neutral,
    required this.total,
  });

  @override
  List<Object> get props =>
      [happy, sad, fear, disgust, angry, surprise, neutral, total];
}

class RecapError extends RecapState {
  final String errorMessage;

  const RecapError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class RecapLoadedLatest extends RecapState {
  final String moodDetected;

  const RecapLoadedLatest({
    required this.moodDetected,
  });
}
