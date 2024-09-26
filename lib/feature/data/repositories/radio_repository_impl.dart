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
  Future<List<RadioStationEntity>?> getAllStations({
    int? offset,
    int? limit,
  }) async {
    List<RadioStation> response = await radioRemoteDataSource.getAllStations(
      offset: offset.toString(),
      limit: limit.toString(),
    );
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    response.sort((a, b) => a.votes?.compareTo(b.votes ?? 0) ?? 0);
    return response.reversed.map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByCountry({
    required String? country,
    required int? offset,
    required int? limit,
  }) async {
    List<RadioStation> response = await radioRemoteDataSource.searchByCountry(
        country: country, offset: offset.toString(), limit: limit.toString());
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    response.sort((a, b) => a.votes?.compareTo(b.votes ?? 0) ?? 0);
    return response.reversed.map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByGenre({
    required String? genre,
    required int? offset,
    required int? limit,
  }) async {
    List<RadioStation> response = await radioRemoteDataSource.searchByGenre(
      genre: genre,
      offset: offset.toString(),
      limit: limit.toString(),
    );
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    response.sort((a, b) => a.votes?.compareTo(b.votes ?? 0) ?? 0);
    return response.reversed.map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByLanguage({
    required String? language,
    required int? offset,
    required int? limit,
  }) async {
    List<RadioStation> response = await radioRemoteDataSource.searchByLanguage(
      language: language,
      offset: offset.toString(),
      limit: limit.toString(),
    );
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    response.sort((a, b) => a.votes?.compareTo(b.votes ?? 0) ?? 0);
    return response.reversed.map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioStationEntity>> searchByStationName({
    required String? name,
    required int? offset,
    required int? limit,
  }) async {
    List<RadioStation> response =
        await radioRemoteDataSource.searchByStationName(
      name: name,
      offset: offset.toString(),
      limit: limit.toString(),
    );
    List<RadioStationEntity> favouriteRadioStations =
        await getFavouriteRadioStations();
    response.sort((a, b) => a.votes?.compareTo(b.votes ?? 0) ?? 0);
    return response.reversed.map(
      (e) {
        return e.toRadioStationsEntity().copyWith(
            isFavourite:
                favouriteRadioStations.any((element) => element.url == e.url));
      },
    ).toList();
  }

  @override
  Future<List<RadioType>> getAllCountries() async {
    return (await radioRemoteDataSource.getAllCountries()).where(
      (RadioType e) {
        return e.name != null &&
            e.name?.isNotEmpty == true &&
            (e.stationcount ?? 0) > 0;
      },
    ).toList();
  }

  @override
  Future<List<RadioType>> getAllTags() async {
    return (await radioRemoteDataSource.getAllTags()).where(
      (RadioType e) {
        return e.name != null &&
            e.name?.isNotEmpty == true &&
            (e.stationcount ?? 0) > 0;
      },
    ).toList();
  }

  @override
  Future<List<RadioType>> getAllLanguages() async {
    return (await radioRemoteDataSource.getAllLanguages()).where(
      (RadioType e) {
        return e.name != null &&
            e.name?.isNotEmpty == true &&
            (e.stationcount ?? 0) > 0;
      },
    ).toList();
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
