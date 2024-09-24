import '../../../../core/error/failures/failure.dart';

abstract class RadioLanguageStationsStates {}

class RadioLanguageStationsEmptyState extends RadioLanguageStationsStates {}

class RadioLanguageStationsLoadingState extends RadioLanguageStationsStates {}

class RadioLanguageStationsLoadedState<T> extends RadioLanguageStationsStates {
  final T? data;

  RadioLanguageStationsLoadedState({required this.data}) : assert(data != null);
}

class RadioLanguageStationsErrorState extends RadioLanguageStationsStates {
  final Failure? failure;

  RadioLanguageStationsErrorState({required this.failure});
}
