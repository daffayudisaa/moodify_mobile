import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_event.dart';
import 'package:moodify_mobile/presentation/bloc/auth/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'access_token', accessToken); // Menyimpan token sebagai string
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await http
          .post(
            Uri.parse('http://sirw.my.id/login/'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'email': event.email,
              'password': event.password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Parsing respons JSON
        final data = json.decode(response.body);

        final token = data['access_token'];

        if (JwtDecoder.isExpired(token)) {
          emit(const AuthError("Token has expired"));
          return;
        }

        final decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken['sub'];

        await saveUserId(userId); // Simpan userId
        await saveAccessToken(token); // Simpan access token
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data dari SharedPreferences
    emit(AuthInitial());
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await http
          .post(
            Uri.parse('http://sirw.my.id/signup/'),
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

      if (response.statusCode == 201) {
        // ignore: unused_local_variable
        final data = json.decode(response.body);

        emit(AuthAuthenticated());
      } else {
        emit(const AuthError("Sign up failed"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

Future<void> saveAccessToken(String accessToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('access_token', accessToken);
}

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('access_token');
  return accessToken != null && accessToken.isNotEmpty;
}
