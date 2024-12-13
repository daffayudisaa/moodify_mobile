import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_event.dart';
import 'package:moodify_mobile/presentation/bloc/recap_mood/recap/recap_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecapBloc extends Bloc<RecapEvent, RecapState> {
  RecapBloc() : super(RecapInitial()) {
    on<LoadRecap>(_onLoadRecap);
    on<LoadRecapLatest>(_onLoadRecapLatest);
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

  Future<void> _onLoadRecap(LoadRecap event, Emitter<RecapState> emit) async {
    emit(RecapLoading());
    try {
      final credentials = await _loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null || accessToken == null || accessToken.isEmpty) {
        emit(const RecapError("Invalid user credentials"));
        return;
      }

      final response = await http.get(
        Uri.parse('http://sirw.my.id/expression_analysis/mood_counts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(RecapLoaded(
          happy: data['Happy'],
          sad: data['Sad'],
          fear: data['Fear'],
          disgust: data['Disgust'],
          angry: data['Angry'],
          surprise: data['Surprise'],
          neutral: data['Neutral'],
          total: data['Total'],
        ));
        print(data);
      } else {
        emit(RecapError("Failed to load profile: ${response.body}"));
      }
    } catch (e) {
      emit(RecapError(e.toString()));
    }
  }

  Future<void> _onLoadRecapLatest(
    LoadRecapLatest event,
    Emitter<RecapState> emit,
  ) async {
    emit(RecapLoading());
    try {
      final credentials = await _loadUserCredentials();
      final userId = credentials['userId'];
      final accessToken = credentials['accessToken'];

      if (userId == null || accessToken == null || accessToken.isEmpty) {
        emit(const RecapError("Invalid user credentials"));
        return;
      }

      final response = await http.get(
        Uri.parse('http://sirw.my.id/expression_analysis/latest'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(RecapLoadedLatest(
          moodDetected: data['MoodDetected'].toString(),
        ));
        print(data);
      } else {
        emit(RecapError("Failed to load profile: ${response.body}"));
      }
    } catch (e) {
      emit(RecapError(e.toString()));
    }
  }
}
