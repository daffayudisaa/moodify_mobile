import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/history/history_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodHistoryBloc extends Bloc<MoodHistoryEvent, MoodHistoryState> {
  // The initial skip and limit values
  int skip = 0;
  final int limit = 10; // Number of records per page

  MoodHistoryBloc() : super(MoodHistoryInitialState()) {
    on<FetchHistory>(_onFetchHistory);
    on<LoadMoreHistory>(_onLoadMoreHistory); // Event for loading more data
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
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse(
            'http://sirw.my.id/expression_analysis?skip=$skip&limit=$limit'),
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

        // Update skip for pagination
        skip += limit;

        emit(MoodHistoryLoadedState(userHistory, skip));
      } else if (response.statusCode == 404) {
        emit(MoodHistoryErrorState('Data not found.'));
      } else {
        emit(MoodHistoryErrorState('Failed to load data.'));
      }
    } catch (e) {
      emit(MoodHistoryErrorState('An error occurred: $e'));
    }
  }

  // Method to handle loading more data (pagination)
  Future<void> _onLoadMoreHistory(
      LoadMoreHistory event, Emitter<MoodHistoryState> emit) async {
    if (state is MoodHistoryLoadedState) {
      // Fetch next page
      final currentState = state as MoodHistoryLoadedState;
      final List<Map<String, String>> currentHistory = currentState.userHistory;

      // Fetch next set of data
      emit(MoodHistoryLoadingState());
      try {
        final credentials = await loadUserCredentials();
        final accessToken = credentials['accessToken'];
        final userId = credentials['userId'];

        if (userId == null || accessToken == null) {
          emit(MoodHistoryErrorState(
              'User credentials are missing or invalid.'));
          return;
        }

        final headers = {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse(
              'http://sirw.my.id/expression_analysis?skip=$skip&limit=$limit'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final List data = jsonDecode(response.body);
          final List<Map<String, String>> additionalHistory =
              data.map((history) {
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

          // Add the new data to the existing list
          currentHistory.addAll(additionalHistory);

          // Update skip
          skip += limit;

          emit(MoodHistoryLoadedState(currentHistory, skip));
        } else {
          emit(MoodHistoryErrorState('Failed to load more data.'));
        }
      } catch (e) {
        emit(MoodHistoryErrorState('An error occurred: $e'));
      }
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
