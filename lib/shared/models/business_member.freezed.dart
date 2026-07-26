// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusinessMember _$BusinessMemberFromJson(Map<String, dynamic> json) {
  return _BusinessMember.fromJson(json);
}

/// @nodoc
mixin _$BusinessMember {
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_value')
  String get roleValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool? get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessMemberCopyWith<BusinessMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessMemberCopyWith<$Res> {
  factory $BusinessMemberCopyWith(
          BusinessMember value, $Res Function(BusinessMember) then) =
      _$BusinessMemberCopyWithImpl<$Res, BusinessMember>;
  @useResult
  $Res call(
      {String uid,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      String email,
      @JsonKey(name: 'role_value') String roleValue,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(name: 'joined_at') DateTime joinedAt});
}

/// @nodoc
class _$BusinessMemberCopyWithImpl<$Res, $Val extends BusinessMember>
    implements $BusinessMemberCopyWith<$Res> {
  _$BusinessMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? businessId = null,
    Object? name = null,
    Object? email = null,
    Object? roleValue = null,
    Object? isActive = freezed,
    Object? joinedAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessMemberImplCopyWith<$Res>
    implements $BusinessMemberCopyWith<$Res> {
  factory _$$BusinessMemberImplCopyWith(_$BusinessMemberImpl value,
          $Res Function(_$BusinessMemberImpl) then) =
      __$$BusinessMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      @JsonKey(name: 'business_id') String businessId,
      String name,
      String email,
      @JsonKey(name: 'role_value') String roleValue,
      @JsonKey(name: 'is_active') bool? isActive,
      @JsonKey(name: 'joined_at') DateTime joinedAt});
}

/// @nodoc
class __$$BusinessMemberImplCopyWithImpl<$Res>
    extends _$BusinessMemberCopyWithImpl<$Res, _$BusinessMemberImpl>
    implements _$$BusinessMemberImplCopyWith<$Res> {
  __$$BusinessMemberImplCopyWithImpl(
      _$BusinessMemberImpl _value, $Res Function(_$BusinessMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? businessId = null,
    Object? name = null,
    Object? email = null,
    Object? roleValue = null,
    Object? isActive = freezed,
    Object? joinedAt = null,
  }) {
    return _then(_$BusinessMemberImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessMemberImpl implements _BusinessMember {
  const _$BusinessMemberImpl(
      {required this.uid,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.name,
      required this.email,
      @JsonKey(name: 'role_value') required this.roleValue,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'joined_at') required this.joinedAt});

  factory _$BusinessMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessMemberImplFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String name;
  @override
  final String email;
  @override
  @JsonKey(name: 'role_value')
  final String roleValue;
  @override
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime joinedAt;

  @override
  String toString() {
    return 'BusinessMember(uid: $uid, businessId: $businessId, name: $name, email: $email, roleValue: $roleValue, isActive: $isActive, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessMemberImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.roleValue, roleValue) ||
                other.roleValue == roleValue) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, businessId, name, email, roleValue, isActive, joinedAt);

  /// Create a copy of BusinessMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessMemberImplCopyWith<_$BusinessMemberImpl> get copyWith =>
      __$$BusinessMemberImplCopyWithImpl<_$BusinessMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessMemberImplToJson(
      this,
    );
  }
}

abstract class _BusinessMember implements BusinessMember {
  const factory _BusinessMember(
          {required final String uid,
          @JsonKey(name: 'business_id') required final String businessId,
          required final String name,
          required final String email,
          @JsonKey(name: 'role_value') required final String roleValue,
          @JsonKey(name: 'is_active') final bool? isActive,
          @JsonKey(name: 'joined_at') required final DateTime joinedAt}) =
      _$BusinessMemberImpl;

  factory _BusinessMember.fromJson(Map<String, dynamic> json) =
      _$BusinessMemberImpl.fromJson;

  @override
  String get uid;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'role_value')
  String get roleValue;
  @override
  @JsonKey(name: 'is_active')
  bool? get isActive;
  @override
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt;

  /// Create a copy of BusinessMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessMemberImplCopyWith<_$BusinessMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
