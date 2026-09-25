// import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/business/application/business_providers.dart';
import '../application/dashboard_providers.dart';
import '../../invoices/application/invoice_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final sym = biz?.currencySymbol ?? '';
    final lakh = biz?.useLakhFormat ?? false;
    final statsAsync = ref.watch(dashboardStatsProvider);

    // Convenience fomatter
    String fmt(int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => ref.refresh(dashboardStatsProvider.future),
      child: statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (stats) =>
              ListView(padding: const EdgeInsets.all(16), children: [
                // Business name + greeting
                Text('${biz?.name} - Dashboard' ?? '',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(_greeting(), style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),

                _sectionLabel('Quick Actions'),
                const SizedBox(height: 8),
                Row(children: [
                  _quickAction(context,
                      label: 'New Invoice',
                      icon: Icons.add_circle_outline,
                      route: AppRoutes.createInvoice),
                  _quickAction(context,
                      label: 'Add Product',
                      icon: Icons.storefront_outlined,
                      route: AppRoutes.addProduct),
                  _quickAction(context,
                      label: 'Add Customer',
                      icon: Icons.person_add_outlined,
                      route: AppRoutes.addCustomer),
                ]),
                const SizedBox(height: 20),
                // Revenue cards — 3 in a row
                _sectionLabel('Revenue'),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                      child: _statCard(
                          label: 'Today',
                          value: fmt(stats.revenueToday),
                          icon: Icons.today_outlined,
                          color: Colors.blue)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'This Week',
                          value: fmt(stats.revenueWeek),
                          icon: Icons.date_range_outlined,
                          color: Colors.indigo)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'This Month',
                          value: fmt(stats.revenueMonth),
                          icon: Icons.calendar_month_outlined,
                          color: AppColors.primary)),
                ]),
                const SizedBox(height: 16),

                // Receivables
                _sectionLabel('Receivables'),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                      child: _statCard(
                          label: 'Outstanding',
                          value: fmt(stats.totalOutstanding),
                          icon: Icons.account_balance_wallet_outlined,
                          color: Colors.orange)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'Overdue',
                          value: fmt(stats.overdueAmount),
                          icon: Icons.warning_amber_outlined,
                          color: Colors.red)),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'Draft Inv.',
                          value: stats.draftInvoiceCount.toString(),
                          icon: Icons.drafts_outlined,
                          color: Colors.grey,
                          isCurrency: false)),
                ]),
                const SizedBox(height: 16),

                // Invenaory alerts
                _sectionLabel('Inventory'),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                      child: _statCard(
                          label: 'Low Stock',
                          value: stats.lowStockCount.toString(),
                          icon: Icons.inventory_2_outlined,
                          color: Colors.orange,
                          isCurrency: false,
                          onTap: () => context.go(AppRoutes.inventory))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'Out of Stock',
                          value: stats.outOfStockCount.toString(),
                          icon: Icons.remove_shopping_cart_outlined,
                          color: Colors.red,
                          isCurrency: false,
                          onTap: () => context.go(AppRoutes.inventory))),
                  const SizedBox(width: 8),
                  Expanded(
                      child: _statCard(
                          label: 'Inv. This Month',
                          value: stats.invoiceCountMonth.toString(),
                          icon: Icons.receipt_outlined,
                          color: Colors.teal,
                          isCurrency: false,
                          onTap: () => context.go(AppRoutes.invoices))),
                ]),
                const SizedBox(height: 20),

                // Quick actions

                // Recent invoices
                _sectionLabel('Recent Invoices'),
                const SizedBox(height: 8),
                _RecentInvoices(sym: sym, lakh: lakh),
              ])),
    ));
  }

  Widget _sectionLabel(String t) => Text(t,
      style: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey));

  Widget _statCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    bool isCurrency = true,
    VoidCallback? onTap,
  }) =>
      GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withValues(alpha: 0.2))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: color, size: 20),
                    const SizedBox(height: 8),
                    Text(value,
                        style: TextStyle(
                            fontSize: isCurrency ? 13 : 20,
                            fontWeight: FontWeight.bold,
                            color: color),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Text(label,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                  ])));

  Widget _quickAction(BuildContext context,
          {required String label,
          required IconData icon,
          required String route}) =>
      Expanded(
          child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: () => context.push(route),
            child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(children: [
                  Icon(icon, color: AppColors.primary),
                  const SizedBox(height: 4),
                  Text(label,
                      style: const TextStyle(fontSize: 11),
                      textAlign: TextAlign.center),
                ]))),
      ));

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

// Recent invoices sub-widget
class _RecentInvoices extends ConsumerWidget {
  final String sym;
  final bool lakh;
  const _RecentInvoices({required this.sym, required this.lakh});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoices =
        ref.watch(invoiceListProvider()).asData?.value?.take(5).toList() ?? [];
    if (invoices.isEmpty)
      return const Text('No invoices yet.',
          style: TextStyle(color: Colors.grey));
    return Column(
        children: invoices
            .map((inv) => ListTile(
                  dense: true,
                  title: Text(inv.invoiceNumber),
                  subtitle: Text(inv.status.toUpperCase(),
                      style: const TextStyle(fontSize: 11)),
                  trailing: Text(
                      CurrencyFormatter.format(inv.total, sym: sym, lakh: lakh),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () =>
                      context.push(AppRoutes.invoiceDetail, extra: inv),
                ))
            .toList());
  }
}

// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xF0FFFFFF),
//         title: const Text(
//           style: TextStyle(color: Colors.black),
//           'Dashboard',
//         ),
//       ),
//       body: Center(
//         child: Text('Dashboard - coming soon'),
//       ),
//     );
//   }
// }
