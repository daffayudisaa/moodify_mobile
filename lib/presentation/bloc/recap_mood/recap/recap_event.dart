import 'package:equatable/equatable.dart';

abstract class RecapEvent extends Equatable {
  const RecapEvent();

  @override
  List<Object> get props => [];
}

class LoadRecap extends RecapEvent {}

class LoadRecapLatest extends RecapEvent {}
