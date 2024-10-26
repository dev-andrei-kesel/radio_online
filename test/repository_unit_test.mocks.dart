// Mocks generated by Mockito 5.4.4 from annotations
// in radio_online/test/repository_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:radio_online/feature/data/data_sources/local/data_base/models/db_model.dart'
    as _i7;
import 'package:radio_online/feature/data/data_sources/local/radio_local_data_sources.dart'
    as _i6;
import 'package:radio_online/feature/data/data_sources/remote/radio_remote_data_source.dart'
    as _i2;
import 'package:radio_online/feature/data/models/radio_station.dart' as _i4;
import 'package:radio_online/feature/data/models/radio_type.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [RadioRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRadioRemoteDataSource extends _i1.Mock
    implements _i2.RadioRemoteDataSource {
  MockRadioRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.RadioStation>> getAllStations({
    required String? offset,
    required String? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllStations,
          [],
          {
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);

  @override
  _i3.Future<List<_i4.RadioStation>> searchByStationName({
    required String? name,
    required String? offset,
    required String? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchByStationName,
          [],
          {
            #name: name,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);

  @override
  _i3.Future<List<_i4.RadioStation>> searchByCountry({
    required String? country,
    required String? offset,
    required String? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchByCountry,
          [],
          {
            #country: country,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);

  @override
  _i3.Future<List<_i4.RadioStation>> searchByLanguage({
    required String? language,
    required String? offset,
    required String? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchByLanguage,
          [],
          {
            #language: language,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);

  @override
  _i3.Future<List<_i4.RadioStation>> searchByGenre({
    required String? genre,
    required String? offset,
    required String? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchByGenre,
          [],
          {
            #genre: genre,
            #offset: offset,
            #limit: limit,
          },
        ),
        returnValue:
            _i3.Future<List<_i4.RadioStation>>.value(<_i4.RadioStation>[]),
      ) as _i3.Future<List<_i4.RadioStation>>);

  @override
  _i3.Future<List<_i5.RadioType>> getAllCountries() => (super.noSuchMethod(
        Invocation.method(
          #getAllCountries,
          [],
        ),
        returnValue: _i3.Future<List<_i5.RadioType>>.value(<_i5.RadioType>[]),
      ) as _i3.Future<List<_i5.RadioType>>);

  @override
  _i3.Future<List<_i5.RadioType>> getAllTags() => (super.noSuchMethod(
        Invocation.method(
          #getAllTags,
          [],
        ),
        returnValue: _i3.Future<List<_i5.RadioType>>.value(<_i5.RadioType>[]),
      ) as _i3.Future<List<_i5.RadioType>>);

  @override
  _i3.Future<List<_i5.RadioType>> getAllLanguages() => (super.noSuchMethod(
        Invocation.method(
          #getAllLanguages,
          [],
        ),
        returnValue: _i3.Future<List<_i5.RadioType>>.value(<_i5.RadioType>[]),
      ) as _i3.Future<List<_i5.RadioType>>);
}

/// A class which mocks [RadioLocalDataSources].
///
/// See the documentation for Mockito's code generation for more information.
class MockRadioLocalDataSources extends _i1.Mock
    implements _i6.RadioLocalDataSources {
  MockRadioLocalDataSources() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> insert<T extends _i7.DbModel<dynamic>>(T? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #insert,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> insertAll<T extends _i7.DbModel<dynamic>>(List<T>? list) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertAll,
          [list],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<T?> get<T extends _i7.DbModel<dynamic>>(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i3.Future<T?>.value(),
      ) as _i3.Future<T?>);

  @override
  _i3.Future<Iterable<T>> getTake<T extends _i7.DbModel<dynamic>>({
    int? take,
    int? skip,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTake,
          [],
          {
            #take: take,
            #skip: skip,
          },
        ),
        returnValue: _i3.Future<Iterable<T>>.value(<T>[]),
      ) as _i3.Future<Iterable<T>>);

  @override
  _i3.Future<Iterable<T>> getAll<T extends _i7.DbModel<dynamic>>() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i3.Future<Iterable<T>>.value(<T>[]),
      ) as _i3.Future<Iterable<T>>);

  @override
  _i3.Future<void> update<T extends _i7.DbModel<dynamic>>(T? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> delete<T extends _i7.DbModel<dynamic>>(T? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [model],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
