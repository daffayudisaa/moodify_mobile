import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final DateTime birthDate;
  final String avatar;

  const ProfileLoaded({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    this.avatar = 'default_avatar_url',
  });

  @override
  List<Object> get props =>
      [firstName, lastName, email, gender, birthDate, avatar];
}

class ProfileError extends ProfileState {
  final String errorMessage;

  const ProfileError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ProfileDeleted extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final DateTime birthDate;
  // final String avatar;

  const ProfileUpdated({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    // this.avatar = '',
  });

  @override
  List<Object> get props => [firstName, lastName, email, gender, birthDate];
}
