// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreenPermissionImpl _$$ScreenPermissionImplFromJson(
        Map<String, dynamic> json) =>
    _$ScreenPermissionImpl(
      screenKey: json['screenKey'] as String,
      canView: json['canView'] as bool? ?? true,
      canCreate: json['canCreate'] as bool? ?? false,
      canEdit: json['canEdit'] as bool? ?? false,
      canDelete: json['canDelete'] as bool? ?? false,
    );

Map<String, dynamic> _$$ScreenPermissionImplToJson(
        _$ScreenPermissionImpl instance) =>
    <String, dynamic>{
      'screenKey': instance.screenKey,
      'canView': instance.canView,
      'canCreate': instance.canCreate,
      'canEdit': instance.canEdit,
      'canDelete': instance.canDelete,
    };

_$FieldPermissionImpl _$$FieldPermissionImplFromJson(
        Map<String, dynamic> json) =>
    _$FieldPermissionImpl(
      fieldKey: json['fieldKey'] as String,
      canView: json['canView'] as bool? ?? true,
      canEdit: json['canEdit'] as bool? ?? true,
    );

Map<String, dynamic> _$$FieldPermissionImplToJson(
        _$FieldPermissionImpl instance) =>
    <String, dynamic>{
      'fieldKey': instance.fieldKey,
      'canView': instance.canView,
      'canEdit': instance.canEdit,
    };

_$RolePermissionSetImpl _$$RolePermissionSetImplFromJson(
        Map<String, dynamic> json) =>
    _$RolePermissionSetImpl(
      businessId: json['businessId'] as String,
      roleValue: json['roleValue'] as String,
      screens: (json['screens'] as List<dynamic>?)
              ?.map((e) => ScreenPermission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fields: (json['fields'] as List<dynamic>?)
              ?.map((e) => FieldPermission.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RolePermissionSetImplToJson(
        _$RolePermissionSetImpl instance) =>
    <String, dynamic>{
      'businessId': instance.businessId,
      'roleValue': instance.roleValue,
      'screens': instance.screens,
      'fields': instance.fields,
    };
