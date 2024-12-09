import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
