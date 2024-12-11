import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodHistoryBloc extends Bloc<MoodHistoryEvent, MoodHistoryState> {
  MoodHistoryBloc() : super(MoodHistoryInitialState()) {
    on<FetchHistory>(_onFetchHistory);
  }

  Future<void> _onFetchHistory(
      FetchHistory event, Emitter<MoodHistoryState> emit) async {
    emit(MoodHistoryLoadingState());
    try {
      // Load user credentials (including the access token)
      final credentials = await loadUserCredentials();
      final accessToken = credentials['accessToken'];
      final userId = credentials['userId'];

      // Check if userId and accessToken are null or invalid
      if (userId == null || accessToken == null) {
        emit(MoodHistoryErrorState('User credentials are missing or invalid.'));
        return;
      }

      print('Fetching history for user id: $userId');

      // Set the headers for the request
      final headers = {
        'Authorization':
            'Bearer $accessToken', // Add the authorization token here
        'Content-Type':
            'application/json', // Optional, if the server expects JSON
      };

      final response = await http.get(
        Uri.parse('http://sirw.my.id/expression_analysis'),
        headers: headers,
      );
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Map<String, String>> userHistory = data.map((history) {
          return {
            'userId': history['UserID'].toString(),
            'imageID': history['ImageID'].toString(),
            'SadScore': history['SadScore'].toString(),
            'HappyScore': history['HappyScore'].toString(),
            'FearScore': history['FearScore'].toString(),
            'NeutralScore': history['NeutralScore'].toString(),
            'AngryScore': history['AngryScore'].toString(),
            'DisgustScore': history['DisgustScore'].toString(),
            'SurpriseScore': history['SurpriseScore'].toString(),
            'CreatedAt': history['CreatedAt'].toString(),
            'AnalysisID': history['MoodDetected'].toString(),
          };
        }).toList();

        emit(MoodHistoryLoadedState(userHistory));
      } else if (response.statusCode == 404) {
        emit(MoodHistoryErrorState('Data not found.'));
      } else {
        emit(MoodHistoryErrorState('Failed to load data.'));
      }
    } catch (e) {
      emit(MoodHistoryErrorState('An error occurred: $e'));
    }
  }
}

Future<Map<String, dynamic>> loadUserCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  final userIdString = prefs.getString('user_id');
  final accessToken = prefs.getString('access_token');

  // Ensure the userId is a valid integer or handle null/invalid cases
  final userId = userIdString != null ? int.tryParse(userIdString) : null;

  // Check if accessToken is missing
  if (accessToken == null) {
    throw Exception('Access token is missing.');
  }

  // Return the credentials, with null userId allowed
  return {
    'userId': userId,
    'accessToken': accessToken,
  };
}
