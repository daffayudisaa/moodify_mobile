import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();

  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final DateTime birthDate;
  final String avatar;

  const ProfileLoadedState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    this.avatar = '',
  });

  @override
  List<Object> get props =>
      [firstName, lastName, email, gender, birthDate, avatar];
}

class ProfileUpdatedState extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final DateTime birthDate;
  final String avatar;

  const ProfileUpdatedState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    this.avatar = '',
  });

  @override
  List<Object> get props =>
      [firstName, lastName, email, gender, birthDate, avatar];
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  const ProfileErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
