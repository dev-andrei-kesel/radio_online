// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radio_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RadioType _$RadioTypeFromJson(Map<String, dynamic> json) {
  return _RadioType.fromJson(json);
}

/// @nodoc
mixin _$RadioType {
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  int? get stationcount => throw _privateConstructorUsedError;

  /// Serializes this RadioType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RadioType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RadioTypeCopyWith<RadioType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioTypeCopyWith<$Res> {
  factory $RadioTypeCopyWith(RadioType value, $Res Function(RadioType) then) =
      _$RadioTypeCopyWithImpl<$Res, RadioType>;
  @useResult
  $Res call({String? name, String? code, int? stationcount});
}

/// @nodoc
class _$RadioTypeCopyWithImpl<$Res, $Val extends RadioType>
    implements $RadioTypeCopyWith<$Res> {
  _$RadioTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RadioType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? stationcount = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      stationcount: freezed == stationcount
          ? _value.stationcount
          : stationcount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RadioTypeImplCopyWith<$Res>
    implements $RadioTypeCopyWith<$Res> {
  factory _$$RadioTypeImplCopyWith(
          _$RadioTypeImpl value, $Res Function(_$RadioTypeImpl) then) =
      __$$RadioTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? code, int? stationcount});
}

/// @nodoc
class __$$RadioTypeImplCopyWithImpl<$Res>
    extends _$RadioTypeCopyWithImpl<$Res, _$RadioTypeImpl>
    implements _$$RadioTypeImplCopyWith<$Res> {
  __$$RadioTypeImplCopyWithImpl(
      _$RadioTypeImpl _value, $Res Function(_$RadioTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of RadioType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? code = freezed,
    Object? stationcount = freezed,
  }) {
    return _then(_$RadioTypeImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      stationcount: freezed == stationcount
          ? _value.stationcount
          : stationcount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RadioTypeImpl implements _RadioType {
  const _$RadioTypeImpl(
      {required this.name, required this.code, required this.stationcount});

  factory _$RadioTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RadioTypeImplFromJson(json);

  @override
  final String? name;
  @override
  final String? code;
  @override
  final int? stationcount;

  @override
  String toString() {
    return 'RadioType(name: $name, code: $code, stationcount: $stationcount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadioTypeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.stationcount, stationcount) ||
                other.stationcount == stationcount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, code, stationcount);

  /// Create a copy of RadioType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RadioTypeImplCopyWith<_$RadioTypeImpl> get copyWith =>
      __$$RadioTypeImplCopyWithImpl<_$RadioTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RadioTypeImplToJson(
      this,
    );
  }
}

abstract class _RadioType implements RadioType {
  const factory _RadioType(
      {required final String? name,
      required final String? code,
      required final int? stationcount}) = _$RadioTypeImpl;

  factory _RadioType.fromJson(Map<String, dynamic> json) =
      _$RadioTypeImpl.fromJson;

  @override
  String? get name;
  @override
  String? get code;
  @override
  int? get stationcount;

  /// Create a copy of RadioType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RadioTypeImplCopyWith<_$RadioTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
