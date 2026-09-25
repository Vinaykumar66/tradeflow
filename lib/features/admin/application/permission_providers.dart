import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/di/repository_providers.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/permission.dart';

part 'permission_providers.g.dart';

@riverpod
Stream<RolePermissionSet?> rolePermissions(
    RolePermissionsRef ref, String businessId, String roleValue) {
  return ref
      .watch(permissionRepositoryProvider)
      .streamPermissions(businessId, roleValue);
}

// Stream the CURRENT logged-in user's permissions
// This is what all guard widgets use

@riverpod
Stream<RolePermissionSet?> currentRolePermissions(
    CurrentRolePermissionsRef ref) {
  final member = ref.watch(currentMemberProvider).asData?.value;
  final businessId = ref.watch(activeBusinessIdProvider);
  if (member == null || businessId == null) return const Stream.empty();
  return ref
      .watch(permissionRepositoryProvider)
      .streamPermissions(businessId, member.roleValue);
}

@riverpod
bool hasScreenPermission(
    HasScreenPermissionRef ref, String screenKey, PermissionAction action) {
  final perms = ref.watch(currentRolePermissionsProvider).asData?.value;

  if (perms == null) return false;
  return switch (action) {
    PermissionAction.view => perms.canView(screenKey),
    PermissionAction.create => perms.canCreate(screenKey),
    PermissionAction.edit => perms.canEdit(screenKey),
    PermissionAction.delete => perms.canDelete(screenKey),
  };
}

// Quick check: can current user view a sensitive field?
// Usage: ref.watch(canViewFieldProvider(AppFieldKeys.productCostPrice))

@riverpod
bool canViewField(CanViewFieldRef ref, String fieldKey) {
  final perms = ref.watch(currentRolePermissionsProvider).asData?.value;
  if (perms == null) return false;
  return perms.canViewField(fieldKey);
}

// Quick check: can current user edit a sensitive field?
@riverpod
bool canEditField(CanEditFieldRef ref, String fieldKey) {
  final perms = ref.watch(currentRolePermissionsProvider).asData?.value;
  if (perms == null) return false;
  return perms.canEditField(fieldKey);
}

// Quick check: can current user edit a sensitive field?

// Save updated permissions (Admin only)

@riverpod
class SavePermissionsNotifier extends _$SavePermissionsNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);
  Future<void> save(RolePermissionSet permissions) async {
    state = const AsyncValue.loading();
    final r = await AsyncValue.guard(() =>
        ref.read(permissionRepositoryProvider).savePermissions(permissions));
    state = r;
  }
}
