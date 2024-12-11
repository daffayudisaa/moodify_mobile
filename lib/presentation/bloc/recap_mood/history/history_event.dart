import 'package:equatable/equatable.dart';

abstract class MoodHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHistory extends MoodHistoryEvent {
  @override
  List<Object?> get props => [];
}

class GetImageHistory extends MoodHistoryEvent {
  final String imageId;

  GetImageHistory(this.imageId);

  @override
  List<Object?> get props => [imageId];
}
