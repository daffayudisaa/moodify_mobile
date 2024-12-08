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
        // Ambil userId dan accessToken dari SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final userIdString = prefs.getString('user_id');
        final accessToken = prefs.getString('access_token');

// Konversi userId dari String ke int
        final userId = int.tryParse(userIdString ?? '');

        print('user id: $userId');
        print('access token: $accessToken');

        // Periksa jika token atau userId tidak ditemukan
        if (userId == null) {
          emit(const ProfileErrorState(errorMessage: "User ID not found"));
          return;
        }

        if (accessToken == null || accessToken.isEmpty) {
          emit(const ProfileErrorState(errorMessage: "Access token not found"));
          return;
        }

        // Panggil API untuk mengambil data profil
        final response = await http.get(
          Uri.parse('http://sirw.my.id/users/$userId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (response.statusCode == 200) {
          // Parse data profil
          final data = json.decode(response.body);

          emit(ProfileLoadedState(
            firstName: data['Firstname'] ?? 'Default FirstName',
            lastName: data['Lastname'] ?? 'Default LastName',
            email: data['Email'] ?? 'Default Email',
            gender: data['Gender'] ?? 'Unknown',
            birthDate: (DateTime.parse(data['BirthDate'])),
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

    on<UpdateProfileEvent>((event, emit) {
      // Simpan perubahan profil ke state
      emit(ProfileLoadedState(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        gender: event.gender,
        birthDate: event.birthDate,
      ));
    });
  }
}
