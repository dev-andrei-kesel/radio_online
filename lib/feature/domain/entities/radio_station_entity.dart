import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/data_sources/local/data_base/models/radio_item.dart';

part 'radio_station_entity.freezed.dart';
part 'radio_station_entity.g.dart';

@freezed
class RadioStationEntity with _$RadioStationEntity {
  const factory RadioStationEntity({
    required String? stationUuid,
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
    required bool? isFavourite,
  }) = _RadioStationEntity;

  factory RadioStationEntity.fromJson(Map<String, Object?> json) =>
      _$RadioStationEntityFromJson(json);
}

extension ToRecipeItem on RadioStationEntity {
  RadioItem toRadioItem() {
    return RadioItem(
      id: stationUuid,
      name: name,
      url: url,
      urlResolved: urlResolved,
      homepage: homepage,
      favicon: favicon,
      tags: tags,
      country: country,
      countryCode: countryCode,
      languages: language,
      languageCodes: languageCodes,
      votes: votes,
      codec: codec,
    );
  }
}
