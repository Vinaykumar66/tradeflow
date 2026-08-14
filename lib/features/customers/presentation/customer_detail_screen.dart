import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/permission_keys.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/widgets/field_guard.dart';
import '../../../shared/widgets/permission_guard.dart';
import '../../business/application/business_providers.dart';

class CustomerDetailScreen extends ConsumerWidget {
  final Customer customer;
  const CustomerDetailScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym =
        ref.watch(activeBusinessProvider).asData?.value?.currencySymbol ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(customer.name),
        actions: [
          PermissionGuard(
            screenKey: AppScreenKeys.customers,
            action: PermissionAction.edit,
            child: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    context.push(AppRoutes.editCustomer, extra: customer)),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Over credit limit warning
        if (customer.isOverCreditLimit)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColors.alertRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: AppColors.alertRed.withValues(alpha: 0.4))),
            child: Row(children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.alertRed),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Text('Over Credit Limit',
                        style: TextStyle(
                            color: AppColors.alertRed,
                            fontWeight: FontWeight.bold)),
                    Text(
                        'Outstanding ${customer.formattedOutstanding} '
                        'exceeds limit of ${customer.formattedCreditLimit}',
                        style: const TextStyle(
                            color: AppColors.alertRed, fontSize: 13)),
                  ])),
            ]),
          ),

        // Outstanding balance card
        Card(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outstanding Balance',
                        style: AppTextStyles.labelLarge),
                    const SizedBox(height: 8),
                    Text(customer.formattedOutstanding(sym),
                        style: AppTextStyles.amountLarge.copyWith(
                            color: customer.hasOutstanding
                                ? AppColors.alertRed
                                : AppColors.success)),
                    // Credit limit progress - hidden from Salesperson
                    if (customer.creditLimit > 0)
                      FieldGuard(
                        fieldKey: AppFieldKeys.customerCreditLimit,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Row(children: [
                                Text(
                                    'Credit Limit: ${customer.formattedCreditLimit}',
                                    style: AppTextStyles.bodySmall),
                                const Spacer(),
                                Text(
                                    'Available: ${customer.formattedAvailableCredit}',
                                    style: AppTextStyles.bodySmall),
                              ]),
                              const SizedBox(height: 6),
                              LinearProgressIndicator(
                                value: customer.creditLimit > 0
                                    ? (customer.outstanding /
                                            customer.creditLimit)
                                        .clamp(0.0, 1.0)
                                    : 0,
                                backgroundColor:
                                    AppColors.alertGreen.withValues(alpha: 0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    customer.isOverCreditLimit
                                        ? AppColors.alertRed
                                        : AppColors.alertGreen),
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ]),
                      ),
                  ])),
        ),
        const SizedBox(height: 16),

        // Quick actions
        Row(children: [
          Expanded(
              child: PermissionGuard(
            screenKey: AppScreenKeys.invoices,
            action: PermissionAction.create,
            child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to new invoice with customer pre-filled (Day 31+)
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invoices coming Day 31')));
                },
                icon: const Icon(Icons.receipt_outlined),
                label: const Text('New Invoice')),
          )),
          const SizedBox(width: 8),
          Expanded(
              child: PermissionGuard(
            screenKey: AppScreenKeys.payments,
            action: PermissionAction.create,
            child: OutlinedButton.icon(
                onPressed: () {
                  // Navigate to record payment (Day 41+)
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payments coming Day 41')));
                },
                icon: const Icon(Icons.payments_outlined),
                label: const Text('Payment')),
          )),
        ]),
        const SizedBox(height: 8),
        OutlinedButton.icon(
            onPressed: () =>
                context.push(AppRoutes.customerLedger, extra: customer),
            icon: const Icon(Icons.book_outlined),
            label: const Text('View Ledger')),
        const SizedBox(height: 24),

        // Contact info
        Text('Contact Information', style: AppTextStyles.h3),
        const SizedBox(height: 12),
        if (customer.phone != null)
          ListTile(
              dense: true,
              leading: const Icon(Icons.phone_outlined, size: 20),
              title: Text(customer.phone!)),
        if (customer.email != null)
          ListTile(
              dense: true,
              leading: const Icon(Icons.email_outlined, size: 20),
              title: Text(customer.email!)),
        if (customer.address != null)
          ListTile(
              dense: true,
              leading: const Icon(Icons.location_on_outlined, size: 20),
              title: Text([customer.address, customer.city, customer.state]
                  .whereType<String>()
                  .join(', '))),
        if (customer.gstin != null)
          ListTile(
              dense: true,
              leading: const Icon(Icons.receipt_long_outlined, size: 20),
              title: Text('GSTIN: ${customer.gstin}')),
        if (customer.paymentTerms > 0)
          ListTile(
              dense: true,
              leading: const Icon(Icons.calendar_today_outlined, size: 20),
              title: Text('Payment Terms: Net ${customer.paymentTerms} days')),
      ]),
    );
  }
}
