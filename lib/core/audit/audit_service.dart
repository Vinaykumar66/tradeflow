// Logs events that PostgreSQL triggers cannot capture:
//   - Login and logout events
//   - Who viewed sensitive fields (cost price, credit limit)
//   - Custom events (PDF downloaded, report exported)
//
// Database INSERT/UPDATE/DELETE are logged automatically by triggers.
// This service handles the application layer only.
// Every method uses try/catch - NEVER crashes the app
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/table_constants.dart';
import '../interfaces/i_audit_service.dart';
import '../supabase/supabase_client.dart';

class AuditService implements IAuditService {
  @override
  Future<void> logLogin(
      {required String userId,
      required String userName,
      required String businessId}) async {
    try {
      await supabase.from(SupabaseTables.auditLogs).insert({
        'business_id': businessId,
        'user_id': userId,
        'user_name': userName,
        'action': 'LOGIN',
        'table_name': 'auth',
        'new_data': {'email': supabase.auth.currentUser?.email},
      });
    } catch (e) {
      debugPrint('Audit failed(login): $e');
    }
  }

  @override
  Future<void> logLogout(
      {required String userId,
      required String userName,
      required String businessId}) async {
    try {
      await supabase.from(SupabaseTables.auditLogs).insert({
        'business_id': businessId,
        'user_id': userId,
        'user_name': userName,
        'action': 'LOGOUT',
        'table_name': 'auth',
      });
    } catch (e) {
      debugPrint('Audit failed(logout): $e');
    }
  }

  @override
  Future<void> logSensitiveView(
      {required String userId,
      required String userName,
      required String businessId,
      required String tableName,
      required String recordId,
      required String fieldName}) async {
    try {
      await supabase.from(SupabaseTables.auditLogs).insert({
        'business_id': businessId,
        'user_id': userId,
        'user_name': userName,
        'action': 'VIEW_SENSITIVE',
        'table_name': tableName,
        'record_id': recordId,
        'new_data': {'field_viewed': fieldName},
        'changed_fields': [fieldName],
      });
    } catch (e) {
      debugPrint('Audit failed(sensitive view): $e');
    }
  }

  @override
  Future<void> logCustomEvent(
      {required String userId,
      required String userName,
      required String businessId,
      required String action,
      required String tableName,
      String? recordId,
      Map<String, dynamic>? data}) async {
    try {
      await supabase.from(SupabaseTables.auditLogs).insert({
        'business_id': businessId,
        'user_id': userId,
        'user_name': userName,
        'action': action,
        'table_name': tableName,
        'record_id': recordId,
        'new_data': data,
        'changed_fields': data?.keys.toList(),
      });
    } catch (e) {
      debugPrint('Audit failed($action): $e');
    }
  }
}
