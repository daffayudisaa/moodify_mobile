import 'package:equatable/equatable.dart';

abstract class ScanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PictureUploadRequested extends ScanEvent {
  final String imagePath;

  PictureUploadRequested(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
