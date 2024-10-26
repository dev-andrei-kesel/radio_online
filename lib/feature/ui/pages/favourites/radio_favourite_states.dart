import '../../../../core/error/failures/failure.dart';

abstract class RadioFavouriteStates {}

class FavouriteRadioStationsEmptyState extends RadioFavouriteStates {}

class FavouriteRadioStationsLoadingState extends RadioFavouriteStates {}

class FavouriteRadioStationsLoadedState<T> extends RadioFavouriteStates {
  final T? data;

  FavouriteRadioStationsLoadedState({required this.data})
      : assert(data != null);
}

class FavouriteRadioStationsErrorState extends RadioFavouriteStates {
  final Failure? failure;

  FavouriteRadioStationsErrorState({required this.failure});
}
