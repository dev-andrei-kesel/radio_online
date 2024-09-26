import '../../../../core/error/failures/failure.dart';

abstract class RadioTypesStates {}

class EmptyState extends RadioTypesStates {}

class LoadingState extends RadioTypesStates {}

class LoadedState<T> extends RadioTypesStates {
  final T? data;

  LoadedState({required this.data}) : assert(data != null);
}

class ErrorState extends RadioTypesStates {
  final Failure? failure;

  ErrorState({required this.failure});
}
