import 'package:equatable/equatable.dart';

abstract class MoodHistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class FetchHistory extends MoodHistoryEvent {
  late int page;
  late int limit;

  FetchHistory({required this.page, required this.limit});
  @override
  List<Object?> get props => [page, limit];
}

class GetImageHistory extends MoodHistoryEvent {
  final String imageId;

  GetImageHistory(this.imageId);

  @override
  List<Object?> get props => [imageId];
}

class LoadMoreHistory extends MoodHistoryEvent {
  @override
  List<Object?> get props => [];
}
