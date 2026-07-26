abstract interface class IAuditService {
  Future<void> logLogin(
      {required String userId,
      required String userName,
      required String businessId});
  Future<void> logLogout(
      {required String userId,
      required String userName,
      required String businessId});
  Future<void> logSensitiveView(
      {required String userid,
      required String userName,
      required String businessId,
      required String tableName,
      required String recordId,
      required String fieldName});

  Future<void> logCustomEvent(
      {required String userId,
      required String userName,
      required String businessId,
      required String action,
      required String tableName,
      String? recordId,
      Map<String, dynamic>? data});
}
