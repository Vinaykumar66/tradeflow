import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tradeflow/features/admin/presentation/business_settings_screen.dart'
    show BusinessSettingsScreen;
import 'package:tradeflow/features/vendors/presentation/vendors_screen.dart';
import '../../features/admin/presentation/printer_settings_screen.dart';
import '../../features/admin/presentation/tax_codes_screen.dart';
import '../../features/admin/presentation/team_members_screen.dart';
import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/business/presentation/join_business_screen.dart';
import '../../features/business/presentation/onboarding_screen.dart';
import '../../features/customers/presentation/add_edit_customer_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/inventory/presentation/inventory_screen.dart';
import '../../features/customers/presentation/customers_screen.dart';
import '../../features/invoices/presentation/invoices_screen.dart';
import '../../features/invoices/presentation/thermal_printer_pairing_screen.dart';
import '../../features/purchases/presentation/create_purchase_bill_screen.dart'
    show CreatePurchaseBillScreen;
import '../../features/purchases/presentation/purchase_bill_detail_screen.dart'
    show PurchaseBillDetailScreen;
import '../../features/purchases/presentation/purchase_bills_screen.dart';
import '../../features/purchases/presentation/record_vendor_payment_screen.dart'
    show RecordVendorPaymentScreen;
import '../../features/purchases/presentation/vendor_ledger_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/admin/presentation/admin_screen.dart';
import '../../features/admin/presentation/permission_settings_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/vendors/presentation/add_edit_vendor_screen.dart';
import '../../shared/models/invoice.dart';
import '../../shared/models/purchase_bill.dart';
import '../../shared/models/vendor.dart';
import '../../shared/widgets/app_shell.dart';
import '../../features/catalog/presentation/catalog_screen.dart';
import '../../features/catalog/presentation/add_edit_product_screen.dart';
import '../../shared/models/product.dart';
import '../../shared/widgets/barcode_scanner_screen.dart';
import '../../features/customers/presentation/customer_detail_screen.dart';
import '../../features/customers/presentation/customer_ledger_screen.dart';
import '../../shared/models/customer.dart';
import '../../features/invoices/presentation/invoices_screen.dart';
import '../../features/invoices/presentation/create_invoice_screen.dart';
import '../../features/customers/presentation/customer_picker_screen.dart';
import '../../features/invoices/presentation/invoice_detail_screen.dart';
import '../../features/invoices/presentation/record_payment_screen.dart';
import '../../features/reports/presentation/gst_compliance_screen.dart';
import '../../features/reports/presentation/gstr1_report_screen.dart';
import '../../features/reports/presentation/hsn_summary_screen.dart';
import '../../features/reports/presentation/gstr3b_summary_screen.dart';

import 'router_notifier.dart';

part 'app_router.g.dart';

abstract class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';
  static const String inventory = '/inventory';
  static const String customers = '/customers';
  static const String invoices = '/invoices';
  static const String reports = '/reports';
  static const String admin = '/admin';
  static const String profile = '/profile';
  static const String permissionSettings = '/permission-settings';
  static const String catalog = '/catalog';
  static const String addProduct = '/catalog/add';
  static const String editProduct = '/catalog/edit';
  static const String barcodeScanner = '/barcode-scanner';
  static const String addCustomer = '/customers/add';
  static const String editCustomer = '/customers/edit';
  static const String customerDetail = '/customers/detail';
  static const String customerLedger = '/customers/ledger';
  static const String createInvoice = '/invoices/create';
  static const String invoiceDetail = '/invoices/detail';
  static const String customerPicker = '/customers/picker';
  static const String recordPayment = '/invoices/payment';
  static const String taxCodes = '/admin/tax-codes';
  static const String businessSettings = '/admin/business-settings';
  static const String printerSettings = '/admin/printer-settings';
  static const String thermalPairing = '/invoices/thermal-pairing';
  static const String gstCompliance = '/reports/gst';
  static const String gstr1Report = '/reports/gst/gstr1';
  static const String hsnSummary = '/reports/gst/hsn';
  static const String gstr3bSummary = '/reports/gst/gstr3b';
  static const String joinBusiness = '/join-business';
  static const String manageTeamMembers = '/admin/manage-team';
  static const String vendors = '/vendors';
  static const String addVendor = '/vendors/add';
  static const String editVendor = '/vendors/edit';
  static const String payVendor = '/vendors/pay';
  // static const String purchaseBillDetail = '/purchases/detail';
  static const String purchases = '/purchases';
  static const String createPurchaseBill = '/purchases/create';
  static const String vendorLedger = '/vendors/ledger';
}

const _publicRoutes = [AppRoutes.login, AppRoutes.signup, AppRoutes.onboarding];

@riverpod
GoRouter appRouter(Ref ref) {
  // Watch auth state so router rebuilds on auth change
  // Use watch not read — this tells Riverpod to rebuild the router
  // provider when auth changes, which refreshes GoRouter correctly
  final authState = ref.watch(supabaseAuthStateProvider);
  // Create notifier once using ref.watch
  // Do not create RouterNotifier inside the function body
  // Use keepAlive to prevent disposal during navigation
  ref.keepAlive();
  final notifier = RouterNotifier(ref);
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: notifier,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Wait for auth to finish loading
      // If auth state is still loading return null — do not redirect yet
      // This prevents the loop caused by redirecting before auth settles
      if (authState is AsyncLoading) {
        return null;
      }
      final user = ref.read(currentSupabaseUserProvider);
      final isPublic = _publicRoutes.contains(state.matchedLocation);
      if (user == null && !isPublic) return AppRoutes.login;
      if (user != null && state.matchedLocation == AppRoutes.login)
        return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.signup, builder: (_, __) => const SignupScreen()),
      GoRoute(
          path: AppRoutes.onboarding,
          builder: (_, __) => const OnboardingScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
              path: AppRoutes.dashboard,
              builder: (_, __) => const DashboardScreen()),
          GoRoute(
              path: AppRoutes.inventory,
              builder: (_, __) => const InventoryScreen()),

          // GoRoute(
          //     path: AppRoutes.customers,
          //     builder: (_, __) => const CustomersScreen()),
// Customer picker as a full-screen route
          GoRoute(
              path: AppRoutes.customerPicker,
              builder: (_, __) => const CustomerPickerScreen()),

          GoRoute(
              path: AppRoutes.customers,
              builder: (_, __) => const CustomersScreen(),
              routes: [
                GoRoute(
                    path: 'add',
                    builder: (_, __) =>
                        const AddEditCustomerScreen(customer: null)),
                GoRoute(
                    path: 'edit',
                    builder: (_, s) =>
                        AddEditCustomerScreen(customer: s.extra as Customer?)),
                GoRoute(
                    path: 'detail',
                    builder: (_, s) =>
                        CustomerDetailScreen(customer: s.extra as Customer)),
                GoRoute(
                    path: 'ledger',
                    builder: (_, s) =>
                        CustomerLedgerScreen(customer: s.extra as Customer)),
              ]),

          GoRoute(
              path: AppRoutes.vendors,
              builder: (_, __) => const VendorsScreen(),
              routes: [
                GoRoute(
                    path: 'add',
                    builder: (_, __) =>
                        const AddEditVendorScreen(vendor: null)),
                GoRoute(
                    path: 'edit',
                    builder: (_, s) =>
                        AddEditVendorScreen(vendor: s.extra as Vendor?)),
              ]),
          GoRoute(
              path: AppRoutes.invoices,
              builder: (_, __) => const InvoicesScreen(),
              routes: [
                GoRoute(
                    path: 'create',
                    builder: (_, __) => const CreateInvoiceScreen()),
                GoRoute(
                    path: 'detail',
                    builder: (_, s) =>
                        InvoiceDetailScreen(invoice: s.extra as Invoice)),
                GoRoute(
                    path: 'payment',
                    builder: (_, s) =>
                        RecordPaymentScreen(invoice: s.extra as Invoice)),
              ]),

          // GoRoute(
          //     path: AppRoutes.invoices,
          //     builder: (_, __) => const InvoicesScreen()),
          GoRoute(
              path: AppRoutes.reports,
              builder: (_, __) => const ReportsScreen()),
          GoRoute(
              path: AppRoutes.admin, builder: (_, __) => const AdminScreen()),
          GoRoute(
              path: AppRoutes.profile,
              builder: (_, __) => const ProfileScreen()),
          GoRoute(
            path: AppRoutes.permissionSettings,
            builder: (_, __) => const PermissionSettingsScreen(),
          ),

          GoRoute(
              path: AppRoutes.catalog,
              builder: (_, __) => const CatalogScreen(),
              routes: [
                GoRoute(
                    path: 'add',
                    builder: (_, s) => AddEditProductScreen(
                        product: null,
                        initialBarcode:
                            s.extra is String ? s.extra as String : null)),
                GoRoute(
                    path: 'edit',
                    builder: (_, s) => AddEditProductScreen(
                        product: s.extra as Product?, initialBarcode: null)),
              ]),
          // GoRoute(
          //     path: AppRoutes.barcodeScanner,
          //     builder: (_, __) => const BarcodeScannerScreen()),
          GoRoute(
              path: AppRoutes.barcodeScanner,
              pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true, child: BarcodeScannerScreen())),
          GoRoute(
              path: AppRoutes.taxCodes,
              builder: (_, __) => const TaxCodesScreen()),
          GoRoute(
              path: AppRoutes.businessSettings,
              builder: (_, __) => const BusinessSettingsScreen()),
          GoRoute(
              path: AppRoutes.printerSettings,
              builder: (_, __) => const PrinterSettingsScreen()),
          GoRoute(
              path: AppRoutes.thermalPairing,
              builder: (_, __) => const ThermalPrinterPairingScreen()),
          GoRoute(
              path: AppRoutes.gstCompliance,
              builder: (_, __) => const GstComplianceScreen()),
          GoRoute(
              path: AppRoutes.gstr1Report,
              builder: (_, __) => const Gstr1ReportScreen()),
          GoRoute(
              path: AppRoutes.hsnSummary,
              builder: (_, __) => const HsnSummaryScreen()),
          GoRoute(
              path: AppRoutes.gstr3bSummary,
              builder: (_, __) => const Gstr3bSummaryScreen()),
          GoRoute(
              path: AppRoutes.joinBusiness,
              builder: (_, __) => const JoinBusinessScreen()),
          GoRoute(
              path: AppRoutes.manageTeamMembers,
              builder: (_, __) => const TeamMembersScreen()),

          GoRoute(
              path: AppRoutes.payVendor,
              builder: (_, s) =>
                  RecordVendorPaymentScreen(vendor: s.extra as Vendor)),
          // GoRoute(
          //     path: AppRoutes.purchaseBillDetail,
          //     builder: (_, s) =>
          //         PurchaseBillDetailScreen(bill: s.extra as PurchaseBill)),

          GoRoute(
              path: AppRoutes.purchases,
              builder: (_, __) => const PurchaseBillsScreen(),
              routes: [
                GoRoute(
                    path: 'create',
                    builder: (_, __) => const CreatePurchaseBillScreen()),
                GoRoute(
                    path: 'detail',
                    builder: (_, s) => PurchaseBillDetailScreen(
                        bill: s.extra as PurchaseBill)),
              ]),
          GoRoute(
            path: AppRoutes.vendorLedger,
            builder: (_, s) => VendorLedgerScreen(vendor: s.extra as Vendor),
          )
        ],
      ),
    ],
  );
}
