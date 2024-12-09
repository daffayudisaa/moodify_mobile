import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:moodify_mobile/presentation/bloc/profile/profile_event.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<DeleteAccount>(_onDeleteAccount);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<Map<String, dynamic>> _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final userIdString = prefs.getString('user_id');
    final accessToken = prefs.getString('access_token');
    final userId = int.tryParse(userIdString ?? '');
    return {
      'userId': userId,
      'accessToken': accessToken,
    };
  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final credentials = await _loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null || accessToken == null || accessToken.isEmpty) {
        emit(const ProfileError("Invalid user credentials"));
        return;
      }

      final response = await http.get(
        Uri.parse('http://sirw.my.id/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(ProfileLoaded(
          firstName: data['Firstname'] ?? 'Default FirstName',
          lastName: data['Lastname'] ?? 'Default LastName',
          email: data['Email'] ?? 'Default Email',
          gender: data['Gender'] ?? 'Unknown',
          birthDate: DateTime.tryParse(data['BirthDate'] ?? '') ??
              DateTime(2000, 1, 1),
          avatar: data['Avatar'] ?? 'default_avatar_url',
        ));
      } else {
        emit(ProfileError("Failed to load profile: ${response.body}"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccount event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final credentials = await _loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null || accessToken == null || accessToken.isEmpty) {
        emit(const ProfileError("Invalid user credentials"));
        return;
      }

      final response = await http.delete(
        Uri.parse('http://sirw.my.id/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        emit(ProfileDeleted());
      } else {
        emit(ProfileError("Failed to delete account: ${response.body}"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    try {
      final credentials = await _loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null || accessToken == null || accessToken.isEmpty) {
        emit(const ProfileError("Invalid user credentials"));
        return;
      }

      final requestBody = json.encode({
        'Firstname': event.firstName,
        'Lastname': event.lastName,
        'Gender': event.gender,
        'BirthDate': event.birthDate,
        'Email': event.email,
      });
      print("Request Body: $requestBody");
      final response = await http.put(
        Uri.parse('http://sirw.my.id/users/$userId/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: requestBody,
      );
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userData = data['user'];

        emit(ProfileUpdated(
          firstName: userData['Firstname'],
          lastName: userData['Lastname'],
          email: userData['Email'],
          gender: userData['Gender'],
          birthDate: DateTime.parse(userData['BirthDate']),
        ));
        add(LoadProfile());
      } else {
        emit(ProfileError("Failed to update profile: ${response.body}"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
