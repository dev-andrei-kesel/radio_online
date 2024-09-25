import 'package:dio/dio.dart';
import 'package:radio_online/feature/data/models/radio_station.dart';
import 'package:retrofit/retrofit.dart';

import '../models/radio_type.dart';

part 'radio_api.g.dart';

@RestApi(baseUrl: 'https://de1.api.radio-browser.info/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('json/countries')
  Future<List<RadioType>> getAllCountries();

  @GET('json/tags')
  Future<List<RadioType>> getAllTags();

  @GET('/json/languages')
  Future<List<RadioType>> getAllLanguages();

  @GET('json/stations?limit={limit}&offset={offset}')
  Future<List<RadioStation>> getAllStations({
    @Path('offset') required String? offset,
    @Path('limit') required String? limit,
  });

  @GET('json/stations/search?name={name}?limit={limit}&offset={offset}')
  Future<List<RadioStation>> searchByStationName({
    @Path('name') required String? name,
    @Path('offset') required String? offset,
    @Path('limit') required String? limit,
  });

  @GET('json/stations/bycountry/{country}?limit={limit}&offset={offset}')
  Future<List<RadioStation>> searchByCountry({
    @Path('country') required String? country,
    @Path('offset') required String? offset,
    @Path('limit') required String? limit,
  });

  @GET('json/stations/bylanguage/{language}?limit={limit}&offset={offset}')
  Future<List<RadioStation>> searchByLanguage({
    @Path('language') required String? language,
    @Path('offset') required String? offset,
    @Path('limit') required String? limit,
  });

  @GET('json/stations/bytag/{genre}?limit={limit}&offset={offset}')
  Future<List<RadioStation>> searchByGenre({
    @Path('genre') required String? genre,
    @Path('offset') required String? offset,
    @Path('limit') required String? limit,
  });
}
