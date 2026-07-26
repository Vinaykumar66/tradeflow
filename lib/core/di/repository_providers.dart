// SINGLE SWITCH POINT - change implementations here to switch databases
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../audit/audit_service.dart';
import '../interfaces/i_audit_service.dart';
import '../interfaces/i_auth_service.dart';
import '../interfaces/i_business_repository.dart';
import '../interfaces/i_storage_service.dart';
import '../interfaces/i_user_repository.dart';
import '../../features/auth/data/supabase_auth_service.dart';
import '../../features/auth/data/user_repository.dart';
import '../../features/business/data/business_repository.dart';
import '../../features/storage/data/cloudflare_r2_storage_service.dart';

part 'repository_providers.g.dart';

@riverpod
IAuthService authService(Ref ref) => SupabaseAuthService();
@riverpod
IUserRepository userRepository(Ref ref) => UserRepository();
@riverpod
IBusinessRepository businessRepository(Ref ref) => BusinessRepository();
@riverpod
IStorageService storageService(Ref ref) => CloudflareR2StorageService();
// @riverpod
// IAuditService auditService(Ref ref) => AuditService();

// AuditService is created later
// lib/core/audit/audit_service.dart
// import '../interfaces/i_audit_service.dart';
// class AuditService implements IAuditService {
//   @override Future<void> logLogin({required String userId,
//     required String userName, required String businessId}) async {}
//   @override Future<void> logLogout({required String userId,
//     required String userName, required String businessId}) async {}
//   @override Future<void> logSensitiveView({required String userId,
//     required String userName, required String businessId,
//     required String tableName, required String recordId,
//     required String fieldName}) async {}
//   @override Future<void> logCustomEvent({required String userId,
//     required String userName, required String businessId,
//     required String action, required String tableName,
//     String? recordId, Map<String,dynamic>? data}) async {}
// }
