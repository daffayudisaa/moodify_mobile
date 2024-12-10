import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:moodify_mobile/presentation/bloc/music/music.state.dart';
import 'dart:convert';
import 'package:moodify_mobile/presentation/bloc/music/music_event.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicInitial()) {
    on<FetchMusic>(_onFetchMusic);
  }

  Future<void> _onFetchMusic(FetchMusic event, Emitter<MusicState> emit) async {
    emit(MusicLoading());
    try {
      print('Fetching music for mood: ${event.mood}');

      final response = await http
          .get(Uri.parse('http://sirw.my.id/music_dataset/mood/${event.mood}'));
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Map<String, String>> filteredSongs = data.map((song) {
          return {
            'title': song['MusicTitle'].toString(),
            'artist': song['MusicArtist'].toString(),
            'duration': song['Duration'].toString(),
            'image': song['ImageUrl'].toString(),
            'url': song['SongUrl'].toString(),
            'mood': song['MoodClassification'].toString(),
          };
        }).toList();

        emit(MusicLoaded(filteredSongs));
      } else if (response.statusCode == 404) {
        emit(MusicError('No songs found for the selected mood.'));
      } else {
        emit(MusicError('Failed to fetch songs. Please try again.'));
      }
    } catch (e) {
      emit(MusicError('Failed to fetch songs. Please try again.'));
    }
  }
}
