import 'package:radio_online/feature/data/data_sources/local/data_base/models/radio_item.dart';
import 'package:radio_online/feature/data/data_sources/local/radio_local_data_sources.dart';
import 'package:radio_online/feature/data/models/radio_station.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

import '../../domain/repositories/radio_repository.dart';
import '../data_sources/remote/radio_remote_data_source.dart';
import '../models/radio_type.dart';

class RadioRepositoryImpl implements RadioRepository {
  final RadioRemoteDataSource radioRemoteDataSource;
  final RadioLocalDataSources radioLocalDataSource;

  RadioRepositoryImpl({
    required this.radioRemoteDataSource,
    required this.radioLocalDataSource,
  });

  @override
  Future<List<RadioStationEntity>?> getAllStations() async {
    List<RadioStation> response = await radioRemoteDataSource.getAllStations();
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    return response.where((RadioStation e) {
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
    }).map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByCountry(
      {required String? country}) async {
    List<RadioStation> response =
        await radioRemoteDataSource.searchByCountry(country: country);
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();

    return response.where((RadioStation e) {
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
    }).map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByGenre(
      {required String? genre}) async {
    List<RadioStation> response =
        await radioRemoteDataSource.searchByGenre(genre: genre);
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();

    return response.where((RadioStation e) {
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
    }).map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByLanguage(
      {required String? language}) async {
    List<RadioStation> response =
        await radioRemoteDataSource.searchByLanguage(language: language);
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();

    return response.where((RadioStation e) {
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
    }).map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByStationName(
      {required String? name}) async {
    List<RadioStation> response =
        await radioRemoteDataSource.searchByStationName(name: name);
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();

    return response.where((RadioStation e) {
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
    }).map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioType>> getAllCountries() async {
    return radioRemoteDataSource.getAllCountries();
  }

  @override
  Future<List<RadioType>> getAllTags() async {
    return radioRemoteDataSource.getAllTags();
  }

  @override
  Future<List<RadioType>> getAllLanguages() async {
    return radioRemoteDataSource.getAllLanguages();
  }

  @override
  Future<void> addFavouriteRadioStations(
      RadioStationEntity radioStation) async {
    radioLocalDataSource.insert<RadioItem>(radioStation.toRadioItem());
  }

  @override
  Future<List<RadioStationEntity>> getFavouriteRadioStations() async {
    return (await radioLocalDataSource.getAll<RadioItem>())
        .map((e) => e.toRadioStationsEntity())
        .toList();
  }

  @override
  Future<void> removeFavouriteRadioStations(
      RadioStationEntity radioStation) async {
    radioLocalDataSource.delete<RadioItem>(radioStation.toRadioItem());
  }
}
