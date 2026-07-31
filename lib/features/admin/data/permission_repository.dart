import 'dart:convert';
import '../../../core/constants/permission_keys.dart';
import '../../../core/constants/table_constants.dart';
import '../../../core/interfaces/i_permission_repository.dart';
import '../../../core/permissions/default_permissions.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/permission.dart';

class PermissionRepository implements IPermissionRepository {
  @override
  Stream<RolePermissionSet?> streamPermissions(
      String businessId, String roleValue) {
    return supabase
        .from(SupabaseTables.rolePermissions)
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .map((rows) {
          final row =
              rows.where((r) => r['role_value'] == roleValue).firstOrNull;
          if (row == null) return null;
          return _fromRow(row);
        });
  }

  @override
  Future<RolePermissionSet?> getPermissions(
      String businessId, String roleValue) async {
    final row = await supabase
        .from(SupabaseTables.rolePermissions)
        .select()
        .eq('business_id', businessId)
        .eq('role_value', roleValue)
        .maybeSingle();
    if (row == null) return null;
    return _fromRow(row);
  }

  @override
  Future<void> savePermissions(RolePermissionSet permissions) async {
    final payload = {
      'business_id': permissions.businessId,
      'role_value': permissions.roleValue,
      'screens': jsonEncode({
        'screens': permissions.screens.map((s) => s.toJson()).toList(),
        'fields': permissions.fields.map((f) => f.toJson()).toList(),
      }),
    };
    await supabase
        .from(SupabaseTables.rolePermissions)
        .upsert(payload, onConflict: 'business_id,role_value');
  }

  @override
  Future<void> seedDefaultPermissions(String businessId) async {
    // Seed all 3 roles at once on business creation
    await Future.wait([
      savePermissions(DefaultPermissions.admin(businessId)),
      savePermissions(DefaultPermissions.salesperson(businessId)),
      savePermissions(DefaultPermissions.accountant(businessId)),
    ]);
  }

  RolePermissionSet _fromRow(Map<String, dynamic> row) {
    final screensJson = row['screens'];
    if (screensJson == null) {
      return RolePermissionSet(
          businessId: row['business_id'], roleValue: row['role_value']);
    }
    final data = screensJson is String
        ? jsonDecode(screensJson) as Map<String, dynamic>
        : screensJson as Map<String, dynamic>;
    final screens = (data['screens'] as List? ?? [])
        .map((s) => ScreenPermission.fromJson(s as Map<String, dynamic>))
        .toList();
    final fields = (data['fields'] as List? ?? [])
        .map((f) => FieldPermission.fromJson(f as Map<String, dynamic>))
        .toList();
    return RolePermissionSet(
      businessId: row['business_id'],
      roleValue: row['role_value'],
      screens: screens,
      fields: fields,
    );
  }
}
