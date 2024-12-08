import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Panggil API untuk autentikasi
      final response = await http
          .post(
            Uri.parse(
                'http://sirw.my.id/login/'), // Ganti dengan URL API yang sesuai
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'email': event.email,
              'password': event.password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      // Cek status code dari response
      if (response.statusCode == 200) {
        // Jika login sukses, anggap server mengembalikan token atau informasi lain
        // ignore: unused_local_variable
        final data = json.decode(response.body);

        // Lakukan tindakan lain jika perlu (misal, menyimpan token)
        emit(AuthAuthenticated());
      } else {
        // Jika login gagal
        emit(const AuthError("Invalid email or password"));
      }
    } catch (e) {
      // Tangani error apabila ada masalah saat request API
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    // Use SignUpRequested event here
    emit(AuthLoading());
    try {
      final response = await http
          .post(
            Uri.parse(
                'http://sirw.my.id/signup/'), // Change with correct API URL
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'Email': event.email,
              'Password': event.password,
              'Firstname': event.firstName,
              'Lastname': event.lastName,
              'Gender': event.gender,
              'BirthDate': event.birthDate,
            }),
          )
          .timeout(const Duration(seconds: 10));

      // Check the status code of the response
      if (response.statusCode == 201) {
        // If signup is successful, assume the server returns a token or other info
        // ignore: unused_local_variable
        final data = json.decode(response.body);

        // Perform any further actions if needed (e.g., saving the token)
        emit(AuthAuthenticated());
      } else {
        // If signup fails
        emit(const AuthError("Sign up failed"));
      }
    } catch (e) {
      // Handle errors when there's an issue with the API request
      emit(AuthError(e.toString()));
    }
  }
}
