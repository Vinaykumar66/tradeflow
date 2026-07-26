import 'package:flutter/foundation.dart';
import '../constants/table_constants.dart';
import '../supabase/supabase_client.dart';

class StorageTrackingService {
  Future<void> recordUpload({
    required String businessId,
    required String uploadedBy,
    required String bucket,
    required String filePath,
    required String fileName,
    required int fileSizeBytes,
    required String fileType,
    String? entityType,
    String? entityId,
  }) async {
    try {
      await supabase.from(SupabaseTables.storageUsage).insert({
        'business_id': businessId,
        'bucket': bucket,
        'file_path': filePath,
        'file_name': fileName,
        'file_size_bytes': fileSizeBytes,
        'file_type': fileType,
        'entity_type': entityType,
        'entity_id': entityId,
        'uploaded_by': uploadedBy,
      });
    } catch (e) {
      debugPrint('Storage tracking failed: $e');
    }
  }

  Future<void> recordDeletion({
    required String bucket,
    required String filePath,
  }) async {
    try {
      await supabase
          .from(SupabaseTables.storageUsage)
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('bucket', bucket)
          .eq('file_path', filePath);
    } catch (e) {
      debugPrint('Storage deletion tracking failed: $e');
    }
  }

  // Get total storage used by a business in bytes
  Future<int> getUsageBytes(String businessId) async {
    try {
      final data = await supabase
          .from('business_storage_summary')
          .select('total_bytes')
          .eq('business_id', businessId)
          .maybeSingle();
      return (data?['total_bytes'] as int?) ?? 0;
    } catch (_) {
      return 0;
    }
  }

// Returns 0.0 (empty) to 1.0 (full) - use for quota warning UI
  Future<double> getUsagePercent({
    required String businessId,
    required int limitBytes,
  }) async {
    if (limitBytes == 0) {
      return 0;
    }
    final used = await getUsageBytes(businessId);
    return (used / limitBytes).clamp(0.0, 1.0);
  }

// Returns true if business has space for a new file
  Future<bool> hasQuota({
    required String businessId,
    required int limitBytes,
    required int newFileSizeBytes,
  }) async {
    final used = await getUsageBytes(businessId);
    return (used + newFileSizeBytes) <= limitBytes;
  }
}
