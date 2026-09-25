// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BusinessInvite _$BusinessInviteFromJson(Map<String, dynamic> json) {
  return _BusinessInvite.fromJson(json);
}

/// @nodoc
mixin _$BusinessInvite {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_value')
  String get roleValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'invite_code')
  String get inviteCode => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'expired_at')
  DateTime? get expiersAt => throw _privateConstructorUsedError;

  /// Serializes this BusinessInvite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessInviteCopyWith<BusinessInvite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessInviteCopyWith<$Res> {
  factory $BusinessInviteCopyWith(
          BusinessInvite value, $Res Function(BusinessInvite) then) =
      _$BusinessInviteCopyWithImpl<$Res, BusinessInvite>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String email,
      @JsonKey(name: 'role_value') String roleValue,
      @JsonKey(name: 'invite_code') String inviteCode,
      String status,
      @JsonKey(name: 'expired_at') DateTime? expiersAt});
}

/// @nodoc
class _$BusinessInviteCopyWithImpl<$Res, $Val extends BusinessInvite>
    implements $BusinessInviteCopyWith<$Res> {
  _$BusinessInviteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? email = null,
    Object? roleValue = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? expiersAt = freezed,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiersAt: freezed == expiersAt
          ? _value.expiersAt
          : expiersAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessInviteImplCopyWith<$Res>
    implements $BusinessInviteCopyWith<$Res> {
  factory _$$BusinessInviteImplCopyWith(_$BusinessInviteImpl value,
          $Res Function(_$BusinessInviteImpl) then) =
      __$$BusinessInviteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String email,
      @JsonKey(name: 'role_value') String roleValue,
      @JsonKey(name: 'invite_code') String inviteCode,
      String status,
      @JsonKey(name: 'expired_at') DateTime? expiersAt});
}

/// @nodoc
class __$$BusinessInviteImplCopyWithImpl<$Res>
    extends _$BusinessInviteCopyWithImpl<$Res, _$BusinessInviteImpl>
    implements _$$BusinessInviteImplCopyWith<$Res> {
  __$$BusinessInviteImplCopyWithImpl(
      _$BusinessInviteImpl _value, $Res Function(_$BusinessInviteImpl) _then)
      : super(_value, _then);

  /// Create a copy of BusinessInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? email = null,
    Object? roleValue = null,
    Object? inviteCode = null,
    Object? status = null,
    Object? expiersAt = freezed,
  }) {
    return _then(_$BusinessInviteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roleValue: null == roleValue
          ? _value.roleValue
          : roleValue // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: null == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiersAt: freezed == expiersAt
          ? _value.expiersAt
          : expiersAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessInviteImpl implements _BusinessInvite {
  const _$BusinessInviteImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.email,
      @JsonKey(name: 'role_value') required this.roleValue,
      @JsonKey(name: 'invite_code') required this.inviteCode,
      this.status = 'pending',
      @JsonKey(name: 'expired_at') this.expiersAt});

  factory _$BusinessInviteImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessInviteImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String email;
  @override
  @JsonKey(name: 'role_value')
  final String roleValue;
  @override
  @JsonKey(name: 'invite_code')
  final String inviteCode;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'expired_at')
  final DateTime? expiersAt;

  @override
  String toString() {
    return 'BusinessInvite(id: $id, businessId: $businessId, email: $email, roleValue: $roleValue, inviteCode: $inviteCode, status: $status, expiersAt: $expiersAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessInviteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.roleValue, roleValue) ||
                other.roleValue == roleValue) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiersAt, expiersAt) ||
                other.expiersAt == expiersAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, businessId, email, roleValue,
      inviteCode, status, expiersAt);

  /// Create a copy of BusinessInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessInviteImplCopyWith<_$BusinessInviteImpl> get copyWith =>
      __$$BusinessInviteImplCopyWithImpl<_$BusinessInviteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessInviteImplToJson(
      this,
    );
  }
}

abstract class _BusinessInvite implements BusinessInvite {
  const factory _BusinessInvite(
          {required final String id,
          @JsonKey(name: 'business_id') required final String businessId,
          required final String email,
          @JsonKey(name: 'role_value') required final String roleValue,
          @JsonKey(name: 'invite_code') required final String inviteCode,
          final String status,
          @JsonKey(name: 'expired_at') final DateTime? expiersAt}) =
      _$BusinessInviteImpl;

  factory _BusinessInvite.fromJson(Map<String, dynamic> json) =
      _$BusinessInviteImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get email;
  @override
  @JsonKey(name: 'role_value')
  String get roleValue;
  @override
  @JsonKey(name: 'invite_code')
  String get inviteCode;
  @override
  String get status;
  @override
  @JsonKey(name: 'expired_at')
  DateTime? get expiersAt;

  /// Create a copy of BusinessInvite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessInviteImplCopyWith<_$BusinessInviteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
