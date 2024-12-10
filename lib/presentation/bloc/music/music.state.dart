import 'package:equatable/equatable.dart';

class MusicState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<Map<String, String>> songs;

  MusicLoaded(this.songs);

  @override
  List<Object?> get props => [songs];
}

class MusicError extends MusicState {
  final String message;

  MusicError(this.message);

  @override
  List<Object?> get props => [message];
}
