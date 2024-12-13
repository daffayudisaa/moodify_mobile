import 'package:equatable/equatable.dart';

class QuotesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<Map<String, String>> quotes;

  QuotesLoaded(this.quotes);

  @override
  List<Object?> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;

  QuotesError(this.message);

  @override
  List<Object?> get props => [message];
}
