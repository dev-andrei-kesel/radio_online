import 'package:freezed_annotation/freezed_annotation.dart';

part 'radio_type.freezed.dart';

part 'radio_type.g.dart';

@freezed
class RadioType with _$RadioType {
  const factory RadioType(
      {required String? name,
      required String? code,
      required String? stationcount}) = _RadioType;

  factory RadioType.fromJson(Map<String, Object?> json) =>
      _$RadioTypeFromJson(json);
}
