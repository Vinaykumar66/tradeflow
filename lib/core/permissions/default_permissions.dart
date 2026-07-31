// Default permission sets seeded when a business is created.
// Admin gets everything. Salesperson gets billing access.
// Accountant gets reports and payments but no inventory editing.

import '../../core/constants/permission_keys.dart';
import '../../shared/models/permission.dart';

class DefaultPermissions {
//Admin: full access to everything
  static RolePermissionSet admin(String businessId) => RolePermissionSet(
        businessId: businessId,
        roleValue: 'admin',
        screens: [
          const ScreenPermission(
              screenKey: AppScreenKeys.dashboard,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.inventory,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.catalog,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.customers,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.invoices,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.payments,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.reports,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
          const ScreenPermission(
              screenKey: AppScreenKeys.admin,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: true),
        ],
        fields: [
          // Admin sees all sensitive fields
          const FieldPermission(
              fieldKey: AppFieldKeys.productCostPrice,
              canView: true,
              canEdit: true),
          const FieldPermission(
              fieldKey: AppFieldKeys.productTaxRate,
              canView: true,
              canEdit: true),
          const FieldPermission(
              fieldKey: AppFieldKeys.customerCreditLimit,
              canView: true,
              canEdit: true),
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDiscount,
              canView: true,
              canEdit: true),
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDelete,
              canView: true,
              canEdit: true),
        ],
      );

  // Salesperson: can create invoices, cannot see cost price or reports
  static RolePermissionSet salesperson(String businessId) => RolePermissionSet(
        businessId: businessId,
        roleValue: 'salesperson',
        screens: [
          const ScreenPermission(
              screenKey: AppScreenKeys.dashboard,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.inventory,
              canView: true,
              canCreate: false,
              canEdit: true,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.catalog,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.customers,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.invoices,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.payments,
              canView: true,
              canCreate: true,
              canEdit: false,
              canDelete: false),
          // No reports, no admin
          const ScreenPermission(
              screenKey: AppScreenKeys.reports,
              canView: false,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.admin,
              canView: false,
              canCreate: false,
              canEdit: false,
              canDelete: false),
        ],
        fields: [
          // Salesperson cannot see cost price or tax rate
          const FieldPermission(
              fieldKey: AppFieldKeys.productCostPrice,
              canView: false,
              canEdit: false),
          const FieldPermission(
              fieldKey: AppFieldKeys.productTaxRate,
              canView: false,
              canEdit: false),
          // Cannot see or edit credit limit
          const FieldPermission(
              fieldKey: AppFieldKeys.customerCreditLimit,
              canView: false,
              canEdit: false),
          // Cannot give discounts
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDiscount,
              canView: false,
              canEdit: false),
          // Cannot delete invoices
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDelete,
              canView: false,
              canEdit: false),
        ],
      );

  // Accountant: can see everything financial, cannot edit products
  static RolePermissionSet accountant(String businessId) => RolePermissionSet(
        businessId: businessId,
        roleValue: 'accountant',
        screens: [
          const ScreenPermission(
              screenKey: AppScreenKeys.dashboard,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.inventory,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.catalog,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.customers,
              canView: true,
              canCreate: true,
              canEdit: true,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.invoices,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.payments,
              canView: true,
              canCreate: true,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.reports,
              canView: true,
              canCreate: false,
              canEdit: false,
              canDelete: false),
          const ScreenPermission(
              screenKey: AppScreenKeys.admin,
              canView: false,
              canCreate: false,
              canEdit: false,
              canDelete: false),
        ],
        fields: [
          // Accountant sees cost price and credit limit (read-only)
          const FieldPermission(
              fieldKey: AppFieldKeys.productCostPrice,
              canView: true,
              canEdit: false),
          const FieldPermission(
              fieldKey: AppFieldKeys.productTaxRate,
              canView: true,
              canEdit: false),
          const FieldPermission(
              fieldKey: AppFieldKeys.customerCreditLimit,
              canView: true,
              canEdit: false),
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDiscount,
              canView: true,
              canEdit: false),
          const FieldPermission(
              fieldKey: AppFieldKeys.invoiceDelete,
              canView: false,
              canEdit: false),
        ],
      );
}
