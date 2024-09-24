import '../../../../core/error/failures/failure.dart';

abstract class RadioGenreStationsStates {}

class RadioGenreStationsEmptyState extends RadioGenreStationsStates {}

class RadioGenreStationsLoadingState extends RadioGenreStationsStates {}

class RadioGenreStationsLoadedState<T> extends RadioGenreStationsStates {
  final T? data;

  RadioGenreStationsLoadedState({required this.data}) : assert(data != null);
}

class RadioGenreStationsErrorState extends RadioGenreStationsStates {
  final Failure? failure;

  RadioGenreStationsErrorState({required this.failure});
}
