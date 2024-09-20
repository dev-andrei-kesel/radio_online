
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_online/feature/ui/pages/favourites/radio_favourite_states.dart';

import '../../../../core/result/result.dart';
import '../../../../core/use_cases/use_case.dart';
import '../../../domain/entities/radio_station_entity.dart';
import '../../../domain/usercases/favourite_radio_stations_user_case.dart';

class RadioFavouritesCubit extends Cubit<RadioFavouriteStates> {

  final UseCase userCase;

  RadioFavouritesCubit({required this.userCase})
      : super(FavouriteRadioStationsLoadingState());

  Future<void> call() async {
    final RadioResult result = await userCase.call(null).asResult();
    switch (result) {
      case Success():
        if (result.data == null || result.data?.isEmpty) {
          emit(FavouriteRadioStationsEmptyState());
        } else {
          emit(FavouriteRadioStationsLoadedState(data: result.data));
        }
      case Error():
        emit(FavouriteRadioStationsErrorState(failure: result.failure));
      case Loading():
        emit(FavouriteRadioStationsLoadingState());
    }
  }

  Future<void> addFavouriteRadioStations(
      RadioStationEntity? radioStation) async {
    if (radioStation == null) return;
    (userCase as FavouriteRadioStationsUserCase)
        .addFavouriteRadioStations(radioStation);
    call();
  }

  Future<void> removeFavouriteRadioStations(
      RadioStationEntity? radioStation) async {
    if (radioStation == null) return;
    (userCase as FavouriteRadioStationsUserCase)
        .removeFavouriteRadioStations(radioStation);
    call();
  }
}