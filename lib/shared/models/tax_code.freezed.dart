// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaxCode _$TaxCodeFromJson(Map<String, dynamic> json) {
  return _TaxCode.fromJson(json);
}

/// @nodoc
mixin _$TaxCode {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_inclusive')
  bool get isInclusive => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this TaxCode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaxCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaxCodeCopyWith<TaxCode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxCodeCopyWith<$Res> {
  factory $TaxCodeCopyWith(TaxCode value, $Res Function(TaxCode) then) =
      _$TaxCodeCopyWithImpl<$Res, TaxCode>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      double rate,
      @JsonKey(name: 'is_inclusive') bool isInclusive,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$TaxCodeCopyWithImpl<$Res, $Val extends TaxCode>
    implements $TaxCodeCopyWith<$Res> {
  _$TaxCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaxCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? rate = null,
    Object? isInclusive = null,
    Object? isDefault = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      isInclusive: null == isInclusive
          ? _value.isInclusive
          : isInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaxCodeImplCopyWith<$Res> implements $TaxCodeCopyWith<$Res> {
  factory _$$TaxCodeImplCopyWith(
          _$TaxCodeImpl value, $Res Function(_$TaxCodeImpl) then) =
      __$$TaxCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      double rate,
      @JsonKey(name: 'is_inclusive') bool isInclusive,
      @JsonKey(name: 'is_default') bool isDefault,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$TaxCodeImplCopyWithImpl<$Res>
    extends _$TaxCodeCopyWithImpl<$Res, _$TaxCodeImpl>
    implements _$$TaxCodeImplCopyWith<$Res> {
  __$$TaxCodeImplCopyWithImpl(
      _$TaxCodeImpl _value, $Res Function(_$TaxCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? name = null,
    Object? rate = null,
    Object? isInclusive = null,
    Object? isDefault = null,
    Object? isActive = null,
  }) {
    return _then(_$TaxCodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      isInclusive: null == isInclusive
          ? _value.isInclusive
          : isInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaxCodeImpl implements _TaxCode {
  const _$TaxCodeImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.name,
      required this.rate,
      @JsonKey(name: 'is_inclusive') this.isInclusive = false,
      @JsonKey(name: 'is_default') this.isDefault = false,
      @JsonKey(name: 'is_active') this.isActive = true});

  factory _$TaxCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaxCodeImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String name;
  @override
  final double rate;
  @override
  @JsonKey(name: 'is_inclusive')
  final bool isInclusive;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'TaxCode(id: $id, businessId: $businessId, name: $name, rate: $rate, isInclusive: $isInclusive, isDefault: $isDefault, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxCodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.isInclusive, isInclusive) ||
                other.isInclusive == isInclusive) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, businessId, name, rate,
      isInclusive, isDefault, isActive);

  /// Create a copy of TaxCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxCodeImplCopyWith<_$TaxCodeImpl> get copyWith =>
      __$$TaxCodeImplCopyWithImpl<_$TaxCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaxCodeImplToJson(
      this,
    );
  }
}

abstract class _TaxCode implements TaxCode {
  const factory _TaxCode(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      required final String name,
      required final double rate,
      @JsonKey(name: 'is_inclusive') final bool isInclusive,
      @JsonKey(name: 'is_default') final bool isDefault,
      @JsonKey(name: 'is_active') final bool isActive}) = _$TaxCodeImpl;

  factory _TaxCode.fromJson(Map<String, dynamic> json) = _$TaxCodeImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get name;
  @override
  double get rate;
  @override
  @JsonKey(name: 'is_inclusive')
  bool get isInclusive;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of TaxCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaxCodeImplCopyWith<_$TaxCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
