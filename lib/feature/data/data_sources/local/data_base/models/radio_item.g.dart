// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RadioItemImpl _$$RadioItemImplFromJson(Map<String, dynamic> json) =>
    _$RadioItemImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      urlResolved: json['urlResolved'] as String?,
      homepage: json['homepage'] as String?,
      favicon: json['favicon'] as String?,
      tags: json['tags'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      languages: json['languages'] as String?,
      languageCodes: json['languageCodes'] as String?,
      votes: (json['votes'] as num?)?.toInt(),
      codec: json['codec'] as String?,
    );

Map<String, dynamic> _$$RadioItemImplToJson(_$RadioItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'urlResolved': instance.urlResolved,
      'homepage': instance.homepage,
      'favicon': instance.favicon,
      'tags': instance.tags,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'languages': instance.languages,
      'languageCodes': instance.languageCodes,
      'votes': instance.votes,
      'codec': instance.codec,
    };
