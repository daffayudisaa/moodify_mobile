import 'package:equatable/equatable.dart';

abstract class ScanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PictureInitial extends ScanState {}

class PictureUploading extends ScanState {}

class PictureUploadSuccess extends ScanState {
  final Map<String, dynamic>? responseData;

  PictureUploadSuccess(this.responseData);

  @override
  List<Object?> get props => [responseData];
}

class PictureUploadFailure extends ScanState {
  final String errorMessage;

  PictureUploadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
