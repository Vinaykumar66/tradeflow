import '../../shared/models/permission.dart';

abstract interface class IPermissionRepository {
  Stream<RolePermissionSet?> streamPermissions(
      String businessId, String roleValue);

  Future<void> savePermissions(RolePermissionSet permissions);

  Future<RolePermissionSet?> getPermissions(
      String businessId, String roleValue);

  Future<void> seedDefaultPermissions(String businessId);
}
