import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthDate;

  const SignUpRequested(this.email, this.password, this.firstName,
      this.lastName, this.gender, this.birthDate);

  @override
  List<Object?> get props =>
      [email, password, firstName, lastName, gender, birthDate];
}
