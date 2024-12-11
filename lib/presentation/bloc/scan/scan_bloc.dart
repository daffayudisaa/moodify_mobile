import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moodify_mobile/presentation/bloc/scan/scan_even.dart';
import 'package:moodify_mobile/presentation/bloc/scan/scan_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(PictureInitial()) {
    on<PictureUploadRequested>((event, emit) async {
      emit(PictureUploading());

      try {
        final response = await _uploadImage(event.imagePath);

        if (response.statusCode == 201) {
          final responseData = jsonDecode(response.body);
          emit(PictureUploadSuccess(responseData));
        } else {
          emit(PictureUploadFailure(
              errorMessage: 'Upload failed: ${response.reasonPhrase}'));
        }
      } catch (e) {
        emit(PictureUploadFailure(
            errorMessage: 'An error occurred: ${e.toString()}'));
      }
    });
  }

  Future<http.Response> _uploadImage(String imagePath) async {
    final url = Uri.parse('http://sirw.my.id/detect_and_upload');
    final request = http.MultipartRequest('POST', url);

    // Menambahkan file gambar ke request
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    // Memuat kredensial pengguna
    final userCredentials = await loadUserCredentials();
    final accessToken = userCredentials['accessToken'];

    // Menambahkan header Authorization jika token tersedia
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Mengirimkan permintaan
    final streamedResponse = await request.send();
    return http.Response.fromStream(streamedResponse);
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
