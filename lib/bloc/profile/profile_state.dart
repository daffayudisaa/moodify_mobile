import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final DateTime birthDate;

  const ProfileLoadedState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
  });

  @override
  List<Object> get props => [firstName, lastName, email, gender, birthDate];
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  const ProfileErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
