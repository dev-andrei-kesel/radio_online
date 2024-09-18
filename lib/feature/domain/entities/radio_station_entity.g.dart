// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_station_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RadioStationEntityImpl _$$RadioStationEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$RadioStationEntityImpl(
      name: json['name'] as String?,
      url: json['url'] as String?,
      urlResolved: json['urlResolved'] as String?,
      homepage: json['homepage'] as String?,
      favicon: json['favicon'] as String?,
      tags: json['tags'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      language: json['language'] as String?,
      languageCodes: json['languageCodes'] as String?,
      votes: (json['votes'] as num?)?.toInt(),
      codec: json['codec'] as String?,
    );

Map<String, dynamic> _$$RadioStationEntityImplToJson(
        _$RadioStationEntityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'urlResolved': instance.urlResolved,
      'homepage': instance.homepage,
      'favicon': instance.favicon,
      'tags': instance.tags,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'language': instance.language,
      'languageCodes': instance.languageCodes,
      'votes': instance.votes,
      'codec': instance.codec,
    };
