import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulasi proses autentikasi
      await Future.delayed(const Duration(seconds: 2));

      if (event.email == "moodify" && event.password == "123") {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
