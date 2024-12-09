import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordSubmitted({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
