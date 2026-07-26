// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessMemberImpl _$$BusinessMemberImplFromJson(Map<String, dynamic> json) =>
    _$BusinessMemberImpl(
      uid: json['uid'] as String,
      businessId: json['business_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      roleValue: json['role_value'] as String,
      isActive: json['is_active'] as bool? ?? true,
      joinedAt: DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$$BusinessMemberImplToJson(
        _$BusinessMemberImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'business_id': instance.businessId,
      'name': instance.name,
      'email': instance.email,
      'role_value': instance.roleValue,
      'is_active': instance.isActive,
      'joined_at': instance.joinedAt.toIso8601String(),
    };
