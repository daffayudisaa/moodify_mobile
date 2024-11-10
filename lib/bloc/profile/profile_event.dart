import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String birthDate;

  const UpdateProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
  });

  @override
  List<Object> get props => [firstName, lastName, email, gender, birthDate];
}
