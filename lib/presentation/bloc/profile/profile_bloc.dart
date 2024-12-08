import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:moodify_mobile/presentation/bloc/profile/profile_event.dart';
import 'package:moodify_mobile/presentation/bloc/profile/profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(const ProfileLoadingState());

      try {
        // Use the helper function to load user credentials
        final credentials = await loadUserCredentials();
        final userId = credentials['userId'];
        final accessToken = credentials['accessToken'];

        if (userId == null) {
          emit(const ProfileErrorState(errorMessage: "User ID not found"));
          return;
        }

        if (accessToken == null || accessToken.isEmpty) {
          emit(const ProfileErrorState(errorMessage: "Access token not found"));
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

          emit(ProfileLoadedState(
            firstName: data['Firstname'] ?? 'Default FirstName',
            lastName: data['Lastname'] ?? 'Default LastName',
            email: data['Email'] ?? 'Default Email',
            gender: data['Gender'] ?? 'Unknown',
            birthDate: DateTime.parse(data['BirthDate']),
            avatar: data['Avatar'] ?? 'default_avatar_url',
          ));
        } else {
          emit(ProfileErrorState(
              errorMessage: "Failed to load profile: ${response.body}"));
        }
      } catch (e) {
        emit(ProfileErrorState(errorMessage: e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      final credentials = await loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null) {
        emit(const ProfileErrorState(errorMessage: "User ID not found"));
        return;
      }

      if (accessToken == null || accessToken.isEmpty) {
        emit(const ProfileErrorState(errorMessage: "Access token not found"));
        return;
      }

      try {
        final response = await http.put(
          Uri.parse('http://sirw.my.id/users/$userId/profile'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: json.encode({
            'Firstname': event.firstName,
            'Lastname': event.lastName,
            'Gender': event.gender,
            'BirthDate': event.birthDate.toIso8601String(),
          }),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          emit(ProfileUpdatedState(
            firstName: data['Firstname'] ?? event.firstName,
            lastName: data['Lastname'] ?? event.lastName,
            gender: data['Gender'] ?? event.gender,
            birthDate: DateTime.parse(
                data['BirthDate'] ?? event.birthDate.toIso8601String()),
            avatar: data['Avatar'] ?? '',
          ));
        } else {
          emit(const ProfileErrorState(
              errorMessage: 'Failed to update profile.'));
        }
      } catch (e) {
        emit(ProfileErrorState(errorMessage: 'Error: ${e.toString()}'));
      }
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(const ProfileLoadingState());

      try {
        final credentials = await loadUserCredentials();
        final userId = credentials['userId'];
        final accessToken = credentials['accessToken'];

        if (userId == null || accessToken == null) {
          emit(const ProfileErrorState(
              errorMessage: "User credentials not found"));
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
          emit(const ProfileDeletedState());
        } else {
          emit(ProfileErrorState(
              errorMessage: "Failed to delete account: ${response.body}"));
        }
      } catch (e) {
        emit(ProfileErrorState(errorMessage: e.toString()));
      }
    });
  }
}

Future<Map<String, dynamic>> loadUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  final userIdString = prefs.getString('user_id');
  final accessToken = prefs.getString('access_token');

  final userId = int.tryParse(userIdString ?? '');

  return {
    'userId': userId,
    'accessToken': accessToken,
  };
}
