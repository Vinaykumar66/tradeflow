// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessInviteImpl _$$BusinessInviteImplFromJson(Map<String, dynamic> json) =>
    _$BusinessInviteImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      email: json['email'] as String,
      roleValue: json['role_value'] as String,
      inviteCode: json['invite_code'] as String,
      status: json['status'] as String? ?? 'pending',
      expiersAt: json['expired_at'] == null
          ? null
          : DateTime.parse(json['expired_at'] as String),
    );

Map<String, dynamic> _$$BusinessInviteImplToJson(
        _$BusinessInviteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'email': instance.email,
      'role_value': instance.roleValue,
      'invite_code': instance.inviteCode,
      'status': instance.status,
      'expired_at': instance.expiersAt?.toIso8601String(),
    };
