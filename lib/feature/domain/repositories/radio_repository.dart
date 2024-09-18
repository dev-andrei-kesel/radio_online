import 'package:radio_online/feature/data/models/radio_type.dart';

import '../entities/radio_station_entity.dart';

abstract class RadioRepository {
  Future<List<RadioType>> getAllCountries();

  Future<List<RadioType>> getAllTags();

  Future<List<RadioType>> getAllLanguages();

  Future<List<RadioStationEntity>?> getAllStations();

  Future<List<RadioStationEntity>> searchByStationName({required String? name});

  Future<List<RadioStationEntity>> searchByCountry({required String? country});

  Future<List<RadioStationEntity>> searchByLanguage(
      {required String? language});

  Future<List<RadioStationEntity>> searchByGenre({required String? genre});

  Future<List<RadioStationEntity>> searchByLanguageCode(
      {required String? languageCode});
}
