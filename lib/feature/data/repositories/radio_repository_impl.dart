import 'package:radio_online/feature/data/data_sources/local/radio_local_data_sources.dart';
import 'package:radio_online/feature/data/models/radio_station.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

import '../../domain/repositories/radio_repository.dart';
import '../data_sources/remote/radio_remote_data_source.dart';
import '../models/radio_type.dart';

class RadioRepositoryImpl implements RadioRepository {
  final RadioRemoteDataSource radioRemoteDataSource;
  final RadioLocalDataSources radioLocalDataSource;

  RadioRepositoryImpl(
      {required this.radioRemoteDataSource,
      required this.radioLocalDataSource});

  @override
  Future<List<RadioStationEntity>?> getAllStations() async {
    List<RadioStation> response = await radioRemoteDataSource.getAllStations();
    return response
        .where((RadioStation e) {
          return e.url != null &&
              e.url?.isNotEmpty == true &&
              e.name != null &&
              e.name?.isNotEmpty == true &&
              e.country != null &&
              e.country?.isNotEmpty == true &&
              e.language != null &&
              e.language?.isNotEmpty == true &&
              e.tags != null &&
              e.tags?.isNotEmpty == true &&
              e.favicon != null &&
              e.favicon?.isNotEmpty == true;
        })
        .map(
          (e) => e.toRadioStationsEntity(),
        )
        .toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByCountry({required String? country}) {
    // TODO: implement searchByCountry
    throw UnimplementedError();
  }

  @override
  Future<List<RadioStationEntity>> searchByGenre({required String? genre}) {
    // TODO: implement searchByGenre
    throw UnimplementedError();
  }

  @override
  Future<List<RadioStationEntity>> searchByLanguage(
      {required String? language}) {
    // TODO: implement searchByLanguage
    throw UnimplementedError();
  }

  @override
  Future<List<RadioStationEntity>> searchByLanguageCode(
      {required String? languageCode}) {
    // TODO: implement searchByLanguageCode
    throw UnimplementedError();
  }

  @override
  Future<List<RadioStationEntity>> searchByStationName(
      {required String? name}) {
    // TODO: implement searchByStationName
    throw UnimplementedError();
  }

  @override
  Future<List<RadioType>> getAllCountries() {
    // TODO: implement getAllCountries
    throw UnimplementedError();
  }

  @override
  Future<List<RadioType>> getAllTags() {
    // TODO: implement getAllTags
    throw UnimplementedError();
  }

  @override
  Future<List<RadioType>> getAllLanguages() {
    // TODO: implement getAllLanguages
    throw UnimplementedError();
  }
}
