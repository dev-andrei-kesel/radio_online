import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_online/feature/data/data_sources/local/data_base/models/radio_item.dart';
import 'package:radio_online/feature/data/data_sources/local/radio_local_data_sources.dart';
import 'package:radio_online/feature/data/data_sources/remote/radio_remote_data_source.dart';
import 'package:radio_online/feature/data/models/radio_station.dart';
import 'package:radio_online/feature/data/models/radio_type.dart';
import 'package:radio_online/feature/data/repositories/radio_repository_impl.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

import 'repository_unit_test.mocks.dart';

@GenerateMocks([RadioRemoteDataSource, RadioLocalDataSources])
void repositoryUnitTest() {
  late RadioRepositoryImpl repository;
  late MockRadioRemoteDataSource mockRemoteDataSource;
  late MockRadioLocalDataSources mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRadioRemoteDataSource();
    mockLocalDataSource = MockRadioLocalDataSources();
    repository = RadioRepositoryImpl(
      radioRemoteDataSource: mockRemoteDataSource,
      radioLocalDataSource: mockLocalDataSource,
    );
  });

  RadioStation createRadioStation() {
    return const RadioStation(
      changeuuid: '1',
      stationuuid: '1',
      serveruuid: '',
      name: 'name',
      url: 'url',
      url_resolved: 'url_resolved',
      homepage: 'homepage',
      favicon: 'favicon',
      tags: 'tags',
      country: 'country',
      countrycode: 'countrycode',
      iso_3166_2: 'iso_3166_2',
      state: 'state',
      language: 'language',
      languagecodes: 'languagecodes',
      votes: 1,
      lastchangetime: 'lastchangetime',
      lastchangetime_iso8601: '',
      codec: 'codec',
      bitrate: 1,
      hls: 1,
      lastcheckok: 1,
      lastchecktime: 'lastchecktime',
      lastchecktime_iso8601: '',
      lastcheckoktime: 'lastcheckoktime',
      lastcheckoktime_iso8601: '',
      lastlocalchecktime: 'lastlocalchecktime',
      lastlocalchecktime_iso8601: '',
      clicktimestamp: 'clicktimestamp',
      clicktimestamp_iso8601: '',
      clickcount: 1,
      clicktrend: 1,
      ssl_error: 1,
      geo_lat: 0.0,
      geo_long: 0.0,
      has_extended_info: false,
    );
  }

  RadioItem createRadioItem() {
    return const RadioItem(
      name: 'name',
      url: 'url',
      urlResolved: 'urlResolved',
      homepage: 'homepage',
      favicon: 'favicon',
      tags: 'tags',
      country: 'country',
      votes: 1,
      countryCode: 'countryCode',
      languageCodes: 'languageCodes',
      codec: 'codec',
      id: 'id',
      languages: 'languages',
    );
  }

  RadioStationEntity createRadioStationEntity() {
    return const RadioStationEntity(
      stationUuid: 'uuid',
      name: 'name',
      url: 'url',
      urlResolved: 'urlResolved',
      homepage: 'homepage',
      favicon: 'favicon',
      tags: 'tags',
      country: 'country',
      votes: 1,
      countryCode: 'countryCode',
      languageCodes: 'languageCodes',
      language: 'language',
      codec: 'codec',
      isFavourite: true,
    );
  }

  RadioType createRadioType() => const RadioType(
        name: 'US',
        stationcount: 1,
        code: '0',
      );

  // 1 тест
  group(
    'getAllStations',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllStations(
                  offset: anyNamed('offset'), limit: anyNamed('limit')))
              .thenAnswer((_) async => [createRadioStation()]);
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => []);

          // act
          final result = await repository.getAllStations();

          // assert
          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 2 тест
  group(
    'searchByCountry',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          // arrange
          when(mockRemoteDataSource.searchByCountry(
                  country: anyNamed('country'),
                  offset: anyNamed('offset'),
                  limit: anyNamed('limit')))
              .thenAnswer(
            (_) async => [createRadioStation()],
          );
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => []);

          // act
          final result = await repository.searchByCountry(
              country: 'US', offset: 0, limit: 10);

          // assert
          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 3 тест
  group(
    'getAllCountries',
    () {
      test(
        'should return a list of RadioType',
        () async {
          when(mockRemoteDataSource.getAllCountries()).thenAnswer(
            (_) async => [createRadioType()],
          );

          final result = await repository.getAllCountries();

          expect(result, isA<List<RadioType>>());
        },
      );
    },
  );

  // 4 тест
  group(
    'addFavouriteRadioStations',
    () {
      test(
        'should call insert method of local data source',
        () async {
          await repository
              .addFavouriteRadioStations(createRadioStationEntity());

          verify(mockLocalDataSource
                  .insert<RadioItem>(createRadioStationEntity().toRadioItem()))
              .called(1);
        },
      );
    },
  );

  // 5 тест
  group(
    'searchByStationName',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          when(mockRemoteDataSource.searchByStationName(
                  name: anyNamed('name'),
                  offset: anyNamed('offset'),
                  limit: anyNamed('limit')))
              .thenAnswer((_) async => [createRadioStation()]);
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => []);

          final result = await repository.searchByStationName(
              name: 'test', offset: 0, limit: 10);

          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 6 тест
  group(
    'searchByLanguage',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          when(mockRemoteDataSource.searchByLanguage(
                  language: anyNamed('language'),
                  offset: anyNamed('offset'),
                  limit: anyNamed('limit')))
              .thenAnswer((_) async => [createRadioStation()]);
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => []);

          final result = await repository.searchByLanguage(
              language: 'english', offset: 0, limit: 10);

          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 7 тест
  group(
    'searchByGenre',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          when(mockRemoteDataSource.searchByGenre(
                  genre: anyNamed('genre'),
                  offset: anyNamed('offset'),
                  limit: anyNamed('limit')))
              .thenAnswer((_) async => [createRadioStation()]);
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => []);

          final result = await repository.searchByGenre(
              genre: 'rock', offset: 0, limit: 10);

          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 8 тест
  group(
    'getFavouriteRadioStations',
    () {
      test(
        'should return a list of RadioStationEntity',
        () async {
          when(mockLocalDataSource.getAll<RadioItem>())
              .thenAnswer((_) async => [createRadioItem()]);

          final result = await repository.getFavouriteRadioStations();

          expect(result, isA<List<RadioStationEntity>>());
        },
      );
    },
  );

  // 9 тест
  group(
    'removeFavouriteRadioStations',
    () {
      test(
        'should call delete method of local data source',
        () async {
          final radioStation = createRadioStationEntity();

          await repository.removeFavouriteRadioStations(radioStation);

          verify(mockLocalDataSource
                  .delete<RadioItem>(radioStation.toRadioItem()))
              .called(1);
        },
      );
    },
  );

  // 10 тест
  group(
    'getAllTags',
    () {
      test(
        'should return a list of RadioType',
        () async {
          when(mockRemoteDataSource.getAllTags()).thenAnswer((_) async =>
              [const RadioType(name: 'rock', stationcount: 1, code: '0')]);

          final result = await repository.getAllTags();

          expect(result, isA<List<RadioType>>());
        },
      );
    },
  );

  // 11 тест
  group(
    'getAllLanguages',
    () {
      test(
        'should return a list of RadioType',
        () async {
          when(mockRemoteDataSource.getAllLanguages()).thenAnswer((_) async =>
              [const RadioType(name: 'english', stationcount: 1, code: 'en')]);

          final result = await repository.getAllLanguages();

          expect(result, isA<List<RadioType>>());
        },
      );
    },
  );
}
