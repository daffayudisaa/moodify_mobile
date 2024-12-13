import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moodify_mobile/presentation/bloc/quotes/quotes_event.dart';
import 'package:moodify_mobile/presentation/bloc/quotes/quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesBloc() : super(QuotesInitial()) {
    on<FetchQuotes>(_onFetchQuotes);
  }

  Future<void> _onFetchQuotes(
      FetchQuotes event, Emitter<QuotesState> emit) async {
    emit(QuotesLoading());
    try {
      print('Fetching Quotes for mood: ${event.mood}');

      final response =
          await http.get(Uri.parse('http://sirw.my.id/quote/${event.mood}'));
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Map<String, String>> filteredQuotes = data.map((quotes) {
          return {
            'QuoteText': quotes['QuoteText'].toString(),
            'QuoteAuthor': quotes['QuoteAuthor'].toString(),
            'Mood': quotes['Mood'].toString(),
          };
        }).toList();

        emit(QuotesLoaded(filteredQuotes));
      } else if (response.statusCode == 404) {
        emit(QuotesError('No quotes found for the selected mood.'));
      } else {
        emit(QuotesError('Failed to fetch quotes. Please try again.'));
      }
    } catch (e) {
      emit(QuotesError('Failed to fetch quotes. Please try again.'));
    }
  }
}
