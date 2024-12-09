import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class DeleteAccount extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String birthDate;
  // final String avatar;

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    // this.avatar = 'default_avatar_url',
  });

  @override
  List<Object> get props => [firstName, lastName, email, gender, birthDate];
}
