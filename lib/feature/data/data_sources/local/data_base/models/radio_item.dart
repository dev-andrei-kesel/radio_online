import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_online/feature/data/data_sources/local/data_base/models/db_model.dart';
import 'package:radio_online/feature/domain/entities/radio_station_entity.dart';

part 'radio_item.freezed.dart';

part 'radio_item.g.dart';

@freezed
class RadioItem extends DbModel with _$RadioItem {
  const factory RadioItem({
    required int id,
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
  }) = _RadioItem;

  factory RadioItem.fromJson(Map<String, Object?> json) =>
      _$RadioItemFromJson(json);
}

extension ToEntity on RadioItem {
  RadioStationEntity toRadioStationsEntity() {
    return RadioStationEntity(
      name: name,
      url: url,
      urlResolved: urlResolved,
      homepage: homepage,
      favicon: favicon,
      tags: tags,
      country: country,
      countryCode: countryCode,
      language: language,
      languageCodes: languageCodes,
      votes: votes,
      codec: codec,
    );
  }
}
