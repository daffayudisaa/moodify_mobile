import 'dart:io';
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

  const UpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
  });

  @override
  List<Object> get props => [firstName, lastName, email, gender, birthDate];
}

class UploadAvatar extends ProfileEvent {
  final File avatarFile; // No change here, `avatarFile` is required.

  const UploadAvatar(this.avatarFile); // Positional argument for avatarFile

  @override
  List<Object> get props => [avatarFile];
}

class LoadAvatar extends ProfileEvent {
  final int userId;

  const LoadAvatar(this.userId);
}
