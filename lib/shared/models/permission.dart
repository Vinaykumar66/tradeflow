import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission.freezed.dart';
part 'permission.g.dart';

@freezed
abstract class ScreenPermission with _$ScreenPermission {
  const factory ScreenPermission({
    required String screenKey,
    @Default(true) bool canView,
    @Default(false) bool canCreate,
    @Default(false) bool canEdit,
    @Default(false) bool canDelete,
  }) = _ScreenPermission;
  factory ScreenPermission.fromJson(Map<String, dynamic> j) =>
      _$ScreenPermissionFromJson(j);
}

@freezed
abstract class FieldPermission with _$FieldPermission {
  const factory FieldPermission({
    required String fieldKey, // matches AppFieldKeys constant
    @Default(true) bool canView, // false = field hidden from this role
    @Default(true) bool canEdit, // false = field shown but read-only
  }) = _FieldPermission;
  factory FieldPermission.fromJson(Map<String, dynamic> j) =>
      _$FieldPermissionFromJson(j);
}

// Complete permission set for one role in one business
// Stored as JSONB in role_permissions.screens column

@freezed
abstract class RolePermissionSet with _$RolePermissionSet {
  const factory RolePermissionSet({
    required String businessId,
    required String roleValue, // 'admin', 'salesperson', 'accountant'
    @Default([]) List<ScreenPermission> screens,
    @Default([]) List<FieldPermission> fields,
  }) = _RolePermissionSet;
  factory RolePermissionSet.fromJson(Map<String, dynamic> j) =>
      _$RolePermissionSetFromJson(j);
}

extension RolePermissionSetX on RolePermissionSet {
  ScreenPermission? screen(String key) =>
      screens.where((s) => s.screenKey == key).firstOrNull;

  bool canView(String screenKey) => screen(screenKey)?.canView ?? false;
  bool canCreate(String screenKey) => screen(screenKey)?.canCreate ?? false;
  bool canEdit(String screenKey) => screen(screenKey)?.canEdit ?? false;
  bool canDelete(String screenKey) => screen(screenKey)?.canDelete ?? false;

  FieldPermission? field(String key) =>
      fields.where((f) => f.fieldKey == key).firstOrNull;

  bool canViewField(String fieldKey) => field(fieldKey)?.canView ?? true;
  bool canEditField(String fieldKey) => field(fieldKey)?.canEdit ?? true;
}
