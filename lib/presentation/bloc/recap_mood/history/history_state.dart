import 'package:equatable/equatable.dart';

abstract class MoodHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoodHistoryInitialState extends MoodHistoryState {}

class MoodHistoryLoadingState extends MoodHistoryState {}

class MoodHistoryLoadedState extends MoodHistoryState {
  final List<Map<String, String>> userHistory;

  MoodHistoryLoadedState(this.userHistory);

  @override
  List<Object?> get props => [userHistory];
}

class MoodHistoryErrorState extends MoodHistoryState {
  final String message;

  MoodHistoryErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
