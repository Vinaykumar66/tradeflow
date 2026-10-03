import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/purchase_bill.dart';
import '../../../core/utils/gst_period.dart';
import '../data/purchase_bill_repository.dart';

class PurchaseBillsScreen extends ConsumerStatefulWidget {
  const PurchaseBillsScreen({super.key});
  @override
  ConsumerState<PurchaseBillsScreen> createState() =>
      _PurchaseBillsScreenState();
}

class _PurchaseBillsScreenState extends ConsumerState<PurchaseBillsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Bills'),
        actions: [
          IconButton(
              icon: const Icon(Icons.local_shipping_outlined),
              tooltip: 'Manage Vendors',
              onPressed: () => context.push(AppRoutes.vendors)),
        ],
      ),
      body: bizId == null
          ? const SizedBox.shrink()
          : StreamBuilder<List<PurchaseBill>>(
              // Wide period — this screen browses history, not just
              // one GST return period like the compliance reports do.
              stream: PurchaseBillRepository().streamForPeriod(
                  bizId,
                  DateTime.now().subtract(const Duration(days: 365)),
                  DateTime.now()),
              builder: (context, snapshot) {
                final all = snapshot.data ?? [];
                final filtered = _query.isEmpty
                    ? all
                    : all
                        .where((b) => b.billNumber
                            .toLowerCase()
                            .contains(_query.toLowerCase()))
                        .toList();

                return Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                          controller: _searchCtrl,
                          decoration: InputDecoration(
                              hintText: 'Search bill number...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _query.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () => setState(() {
                                            _searchCtrl.clear();
                                            _query = '';
                                          }))
                                  : null,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onChanged: (v) => setState(() => _query = v))),
                  Expanded(
                      child: filtered.isEmpty
                          ? const Center(
                              child: Text('No purchase bills yet',
                                  style: TextStyle(color: Colors.grey)))
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (_, i) {
                                final bill = filtered[i];
                                return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    child: ListTile(
                                        title: Text(bill.billNumber,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600)),
                                        subtitle: Text(
                                            '${bill.billDate.day}/${bill.billDate.month}/${bill.billDate.year}'),
                                        trailing: Text(
                                            'Rs.${(bill.total / 100).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary)),
                                        onTap: () => context.push(
                                            AppRoutes.purchases + '/detail',
                                            extra: bill)));
                              })),
                ]);
              }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push(AppRoutes.createPurchaseBill),
          icon: const Icon(Icons.add),
          label: const Text('New Bill')),
    );
  }
}
