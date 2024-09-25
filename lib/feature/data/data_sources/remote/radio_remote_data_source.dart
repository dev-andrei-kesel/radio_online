import '../../../../common/run_catching.dart';
import '../../../../core/platform/network_info.dart';
import '../../api/radio_api.dart';
import '../../models/radio_station.dart';
import '../../models/radio_type.dart';

abstract class RadioRemoteDataSource {
  Future<List<RadioStation>> getAllStations({
    required String? offset,
    required String? limit,
  });

  Future<List<RadioStation>> searchByStationName({
    required String? name,
    required String? offset,
    required String? limit,
  });

  Future<List<RadioStation>> searchByCountry({
    required String? country,
    required String? offset,
    required String? limit,
  });

  Future<List<RadioStation>> searchByLanguage({
    required String? language,
    required String? offset,
    required String? limit,
  });

  Future<List<RadioStation>> searchByGenre({
    required String? genre,
    required String? offset,
    required String? limit,
  });

  Future<List<RadioType>> getAllCountries();

  Future<List<RadioType>> getAllTags();

  Future<List<RadioType>> getAllLanguages();
}

class RadioRemoteDataSourceImpl implements RadioRemoteDataSource {
  final RestClient client;
  final NetworkInfo networkInfo;

  RadioRemoteDataSourceImpl({required this.client, required this.networkInfo});

  @override
  Future<List<RadioStation>> getAllStations({
    required String? offset,
    required String? limit,
  }) async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.getAllStations(
          offset: offset,
          limit: limit,
        );
      },
    );
  }

  @override
  Future<List<RadioStation>> searchByCountry({
    required String? country,
    required String? offset,
    required String? limit,
  }) async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.searchByCountry(
          country: country,
          offset: offset,
          limit: limit,
        );
      },
    );
  }

  @override
  Future<List<RadioStation>> searchByGenre({
    required String? genre,
    required String? offset,
    required String? limit,
  }) async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.searchByGenre(genre: genre, offset: offset, limit: limit);
      },
    );
  }

  @override
  Future<List<RadioStation>> searchByLanguage({
    required String? language,
    required String? offset,
    required String? limit,
  }) async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.searchByLanguage(
            language: language, offset: offset, limit: limit);
      },
    );
  }

  @override
  Future<List<RadioStation>> searchByStationName({
    required String? name,
    required String? offset,
    required String? limit,
  }) async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.searchByStationName(
          name: name,
          offset: offset,
          limit: limit,
        );
      },
    );
  }

  @override
  Future<List<RadioType>> getAllCountries() async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.getAllCountries();
      },
    );
  }

  @override
  Future<List<RadioType>> getAllLanguages() async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.getAllLanguages();
      },
    );
  }

  @override
  Future<List<RadioType>> getAllTags() async {
    return runCatching(
      isConnected: await networkInfo.isConnected,
      run: () {
        return client.getAllTags();
      },
    );
  }
}
