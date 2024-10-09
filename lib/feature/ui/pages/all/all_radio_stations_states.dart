import '../../../../core/error/failures/failure.dart';

abstract class AllRadioStationsStates {}

class AllRadioStationsEmptyState extends AllRadioStationsStates {}

class AllRadioStationsLoadingState extends AllRadioStationsStates {}

class AllRadioStationsLoadedState<T> extends AllRadioStationsStates {
  final T? data;

  AllRadioStationsLoadedState({required this.data}) : assert(data != null);
}

class AllRadioStationsErrorState extends AllRadioStationsStates {
  final Failure? failure;

  AllRadioStationsErrorState({required this.failure});
}
