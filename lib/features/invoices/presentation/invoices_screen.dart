import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';
import 'widgets/invoice_status_badge.dart';
import '../application/invoice_providers.dart';

class InvoicesScreen extends ConsumerStatefulWidget {
  const InvoicesScreen({super.key});
  @override
  ConsumerState<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends ConsumerState<InvoicesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _searchCtrl = TextEditingController();
  String _query = '';

  static const _tabs = [
    (label: 'All', status: null),
    (label: 'Draft', status: kStatusDraft),
    (label: 'Sent', status: kStatusSent),
    (label: 'Paid', status: kStatusPaid),
    (label: 'Overdue', status: 'overdue'),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final sym = biz?.currencySymbol ?? '';
    final lakh = biz?.useLakhFormat ?? false;
    // Use the invoices stream from the app layer.
    final all = ref.watch(invoiceListProvider()).asData?.value ?? [];

    // Filter by tab and search query
    List<Invoice> filter(String? status) {
      var list = status == null
          ? all
          : status == 'overdue'
              ? all.where((i) => i.isOverdue).toList()
              : all.where((i) => i.status == status).toList();
      if (_query.isNotEmpty) {
        final q = _query.toLowerCase();
        list = list
            .where((i) => i.invoiceNumber.toLowerCase().contains(q))
            .toList();
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Invoices'),

        backgroundColor: Color(0xF0FFFFFF),
        title: const Text(style: TextStyle(color: Colors.black), 'Invoices'),

        bottom: TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabs: _tabs.map((t) => Tab(text: t.label)).toList(),
        ),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                    hintText: 'Search invoice number...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() {
                                  _searchCtrl.clear();
                                  _query = '';
                                }))
                        : null),
                onChanged: (value) => setState(() => _query = value))),
        Expanded(
            child: TabBarView(
                controller: _tabCtrl,
                children: _tabs.map((t) {
                  final invoices = filter(t.status);
                  if (invoices.isEmpty)
                    return const Center(
                        child: Text('No invoices',
                            style: TextStyle(color: Colors.grey)));
                  return ListView.builder(
                      itemCount: invoices.length,
                      itemBuilder: (_, i) =>
                          _InvoiceTile(inv: invoices[i], sym: sym, lakh: lakh));
                }).toList())),
      ]),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.createInvoice),
          icon: const Icon(Icons.add),
          label: const Text('New Invoice')),
    );
  }
}

class _InvoiceTile extends StatelessWidget {
  final Invoice inv;
  final String sym;
  final bool lakh;
  const _InvoiceTile(
      {required this.inv, required this.sym, required this.lakh});
  @override
  Widget build(BuildContext context) {
    final fmt = (int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        title: Row(children: [
          Text(inv.invoiceNumber,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          InvoiceStatusBadge(status: inv.status, overdue: inv.isOverdue),
        ]),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              'Due' +
                  (inv.dueDate == null
                      ? '--'
                      : inv.dueDate!.day.toString() +
                          '/' +
                          inv.dueDate!.month.toString() +
                          '/' +
                          inv.dueDate!.year.toString()),
              style:
                  TextStyle(color: inv.isOverdue ? Colors.red : Colors.grey)),
          if (inv.balanceDue > 0)
            Text('Balance: ${fmt(inv.balanceDue)}',
                style: const TextStyle(color: Colors.orange, fontSize: 12)),
        ]),
        trailing: Text(fmt(inv.total),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: 15)),
        onTap: () => context.push(AppRoutes.invoiceDetail, extra: inv),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class InvoicesScreen extends StatelessWidget {
//   const InvoicesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xF0FFFFFF),
//         title: const Text(style: TextStyle(color: Colors.black), 'Invoices'),
//       ),
//       body: Center(
//         child: Text('Invoices - coming soon'),
//       ),
//     );
//   }
// }
