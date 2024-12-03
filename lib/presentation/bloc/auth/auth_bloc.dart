import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Panggil API untuk autentikasi
      final response = await http
          .post(
            Uri.parse(
                'http://10.0.2.2:8000/login'), // Ganti dengan URL API yang sesuai
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
}
