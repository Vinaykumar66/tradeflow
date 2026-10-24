// lib/core/debug/permission_debug.dart
// TEMPORARY. Delete this file and the bug icon before release.
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradeflow/core/config/app_config.dart';
import 'package:tradeflow/core/constants/permission_keys.dart';
import 'package:tradeflow/core/supabase/supabase_client.dart';
import 'package:tradeflow/features/admin/application/permission_providers.dart';
import 'package:tradeflow/features/business/application/business_providers.dart';

Future<void> debugPermissions(
    WidgetRef ref, String screenKey, PermissionAction action) async {
  if (!kDebugMode) return;
  void log(String s) => debugPrint('PERM $s');
  final actionKey = '$action'.split('.').last;

  log('[0] project=${Uri.parse(AppConfig.supabaseUrl).host} '
      'screenKey="$screenKey" action="$actionKey"');

  final uid = supabase.auth.currentUser?.id;
  final biz = ref.read(activeBusinessProvider).asData?.value;
  log('[1] uid=$uid business=${biz?.id} (${biz?.name})');
  if (uid == null || biz == null) {
    log('STOP: no session, or activeBusinessProvider has not produced a business');
    return;
  }

  final members = await supabase
      .from('business_members')
      .select()
      .eq('uid', uid)
      .eq('business_id', biz.id);
  log('[2] membership rows: $members');
  if (members.isEmpty) {
    log('STOP: no membership row for this business');
    return;
  }
  final role = '${members.first['role_value']}';
  log('[2] role_value="$role" is_active=${members.first['is_active']}');

  List<Map<String, dynamic>> rows;
  try {
    rows = await supabase
        .from('role_permissions')
        .select()
        .eq('business_id', biz.id)
        .eq('role_value', role);
  } catch (e) {
    log('[3] QUERY FAILED (wrong table or column name?): $e');
    return;
  }
  log('[3] ${rows.length} rows for role "$role". '
      'columns: ${rows.isEmpty ? "-" : rows.first.keys.toList()}');
  if (rows.isEmpty) {
    final any = await supabase
        .from('role_permissions')
        .select('role_value')
        .eq('business_id', biz.id);
    log('[3] roles that DO have rows in this business: ${any.map((r) => r['role_value']).toSet()}');
  }
  log('[3] screen keys in table: ${rows.map((r) => r['screen_key']).toSet()}');
  final mine = rows.where((r) => '${r['screen_key']}' == screenKey).toList();
  log('[3] rows for "$screenKey": $mine');
  final dbAllowed = mine
      .any((r) => '${r['action']}' == actionKey && '${r['allowed']}' == 'true');

  final perms = ref.read(currentRolePermissionsProvider);
  log('[4] currentRolePermissionsProvider: ${perms.when(data: (_) => 'data', loading: () => 'STILL LOADING', error: (e, _) => 'ERROR $e')}');
  final allowed = ref.read(hasScreenPermissionProvider(screenKey, action));
  log('[5] hasScreenPermissionProvider -> $allowed');
  log('RESULT database allows=$dbAllowed, app allows=$allowed '
      '${dbAllowed == allowed ? "(consistent)" : "<- MISMATCH, see table (fine if you added an owner bypass)"}');
}
