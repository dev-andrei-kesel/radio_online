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

  @GET('json/stations?limit=500&offset=0')
  Future<List<RadioStation>> getAllStations();

  @GET('json/stations/search?name={name}?limit=50&offset=0')
  Future<List<RadioStation>> searchByStationName(
      {@Path('name') required String? name});

  @GET('json/stations/bycountry/{country}?limit=50&offset=0')
  Future<List<RadioStation>> searchByCountry(
      {@Path('country') required String? country});

  @GET('json/stations/bylanguage/{language}?limit=50&offset=0')
  Future<List<RadioStation>> searchByLanguage(
      {@Path('language') required String? language});

  @GET('json/stations/bytag/{genre}?limit=50&offset=0')
  Future<List<RadioStation>> searchByGenre(
      {@Path('genre') required String? genre});
}
