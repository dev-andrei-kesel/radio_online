import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_station_entity.freezed.dart';
part 'radio_station_entity.g.dart';

@freezed
class RadioStationEntity with _$RadioStationEntity {
  const factory RadioStationEntity({
    required String? name,
    required String? url,
    required String? urlResolved,
    required String? homepage,
    required String? favicon,
    required String? tags,
    required String? country,
    required String? countryCode,
    required String? language,
    required String? languageCodes,
    required int? votes,
    required String? codec,
  }) = _RadioStationEntity;

  factory RadioStationEntity.fromJson(Map<String, Object?> json) =>
      _$RadioStationEntityFromJson(json);
}
