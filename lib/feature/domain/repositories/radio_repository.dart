import 'package:radio_online/feature/data/models/radio_type.dart';

import '../entities/radio_station_entity.dart';

abstract class RadioRepository {
  Future<List<RadioStationEntity>?> getAllStations({
    required int? offset,
    required int? limit,
  });

  Future<List<RadioStationEntity>> searchByStationName({
    required String? name,
    required int? offset,
    required int? limit,
  });

  Future<List<RadioStationEntity>> searchByCountry({
    required String? country,
    required int? offset,
    required int? limit,
  });

  Future<List<RadioStationEntity>> searchByLanguage({
    required String? language,
    required int? offset,
    required int? limit,
  });

  Future<List<RadioStationEntity>> searchByGenre({
    required String? genre,
    required int? offset,
    required int? limit,
  });

  Future<List<RadioStationEntity>> getFavouriteRadioStations();

  Future<void> addFavouriteRadioStations(RadioStationEntity radioStation);

  Future<void> removeFavouriteRadioStations(RadioStationEntity radioStation);

  Future<List<RadioType>> getAllTags();

  Future<List<RadioType>> getAllLanguages();

  Future<List<RadioType>> getAllCountries();
}
