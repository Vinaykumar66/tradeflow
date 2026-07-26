// Single source of truth for all Supabase table and column names.
// NEVER hardcode 'users', 'businesses' etc as strings anywhere else.

abstract class SupabaseTables {
  static const String users = 'users';
  static const String businesses = 'businesses';
  static const String businessMembers = 'business_members';
  static const String rolePermissions = 'role_permissions';
  static const String products = 'products';
  static const String customers = 'customers';
  static const String invoices = 'invoices';
  static const String invoiceItems = 'invoice_items';
  static const String payments = 'payments';
  static const String attachments = 'attachments';
  static const String auditLogs = 'audit_logs';
  static const String storageUsage = 'storage_usage';
  // static const String storageUsage = 'storage_usage';
}
//bucket names are in appconfig files hence commented
// abstract class SupabaseBuckets {
//   static const String productImages = 'product-images';
//   static const String businessLogos = 'business-logos';
//   static const String attachments = 'attachments';
// }
