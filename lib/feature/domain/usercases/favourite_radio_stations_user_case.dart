import 'package:radio_online/core/use_cases/use_case.dart';

import '../entities/radio_station_entity.dart';
import '../repositories/radio_repository.dart';

class FavouriteRadioStationsUserCase<Params>
    extends UseCase<List<RadioStationEntity>?, String?> {
  final RadioRepository repository;

  FavouriteRadioStationsUserCase({required this.repository});

  @override
  Future<List<RadioStationEntity>?> call(
    int? limit,
    int? offset,
    String? params,
  ) async =>
      repository.getFavouriteRadioStations();

  Future<void> addFavouriteRadioStations(
          RadioStationEntity radioStation) async =>
      repository.addFavouriteRadioStations(radioStation);

  Future<void> removeFavouriteRadioStations(
          RadioStationEntity radioStation) async =>
      repository.removeFavouriteRadioStations(radioStation);
}
