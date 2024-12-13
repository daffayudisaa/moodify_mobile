import 'package:equatable/equatable.dart';

abstract class QuotesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchQuotes extends QuotesEvent {
  final String mood;

  FetchQuotes(this.mood);

  @override
  List<Object?> get props => [mood];
}
