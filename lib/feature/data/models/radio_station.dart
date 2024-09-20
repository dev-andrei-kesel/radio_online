import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

part 'radio_station.freezed.dart';

part 'radio_station.g.dart';

@freezed
class RadioStation with _$RadioStation {
  const factory RadioStation({
    required String? changeuuid,
    required String? stationuuid,
    required String? serveruuid,
    required String? name,
    required String? url,
    required String? url_resolved,
    required String? homepage,
    required String? favicon,
    required String? tags,
    required String? country,
    required String? countrycode,
    required String? iso_3166_2,
    required String? state,
    required String? language,
    required String? languagecodes,
    required int? votes,
    required String? lastchangetime,
    required String? lastchangetime_iso8601,
    required String? codec,
    required int? bitrate,
    required int? hls,
    required int? lastcheckok,
    required String? lastchecktime,
    required String? lastchecktime_iso8601,
    required String? lastcheckoktime,
    required String? lastcheckoktime_iso8601,
    required String? lastlocalchecktime,
    required String? lastlocalchecktime_iso8601,
    required String? clicktimestamp,
    required String? clicktimestamp_iso8601,
    required int? clickcount,
    required int? clicktrend,
    required int? ssl_error,
    required double? geo_lat,
    required double? geo_long,
    required bool? has_extended_info,
  }) = _RadioStation;

  factory RadioStation.fromJson(Map<String, Object?> json) =>
      _$RadioStationFromJson(json);
}

extension ToRadioEntity on RadioStation {
  RadioStationEntity toRadioStationsEntity() {
    return RadioStationEntity(
      stationUuid: stationuuid,
      name: name,
      url: url,
      urlResolved: url_resolved,
      homepage: homepage,
      favicon: favicon,
      tags: tags,
      country: country,
      countryCode: countrycode,
      language: language,
      languageCodes: languagecodes,
      votes: votes,
      codec: codec,
      isFavourite: false,
    );
  }
}
