import 'package:equatable/equatable.dart';

abstract class MusicEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMusic extends MusicEvent {
  final String mood;

  FetchMusic(this.mood);

  @override
  List<Object?> get props => [mood];
}
