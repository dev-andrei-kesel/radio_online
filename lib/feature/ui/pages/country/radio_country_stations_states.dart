import '../../../../core/error/failures/failure.dart';

abstract class RadioCountryStationsStates {}

class RadioCountryStationsEmptyState extends RadioCountryStationsStates {}

class RadioCountryStationsLoadingState extends RadioCountryStationsStates {}

class RadioCountryStationsLoadedState<T> extends RadioCountryStationsStates {
  final T? data;

  RadioCountryStationsLoadedState({required this.data}) : assert(data != null);
}

class RadioCountryStationsErrorState extends RadioCountryStationsStates {
  final Failure? failure;

  RadioCountryStationsErrorState({required this.failure});
}
