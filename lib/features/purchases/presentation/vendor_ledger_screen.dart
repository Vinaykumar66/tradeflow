import 'package:flutter/material.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/vendor.dart';

class _LedgerEntry {
  final DateTime date;
  final String label;
  final int amount; // positive = bill (owed more), negative = payment
  const _LedgerEntry(
      {required this.date, required this.label, required this.amount});
}

class VendorLedgerScreen extends StatelessWidget {
  final Vendor vendor;
  const VendorLedgerScreen({super.key, required this.vendor});

  Future<List<_LedgerEntry>> _load() async {
    final bills = await supabase
        .from('purchase_bills')
        .select()
        .eq('vendor_id', vendor.id)
        .order('bill_date');
    final payments = await supabase
        .from('vendor_payments')
        .select()
        .eq('vendor_id', vendor.id)
        .order('paid_at');

    final entries = <_LedgerEntry>[
      ...bills.map((b) => _LedgerEntry(
          date: DateTime.parse(b['bill_date']),
          label: 'Bill ${b['bill_number']}',
          amount: b['total'] as int)),
      ...payments.map((p) => _LedgerEntry(
          date: DateTime.parse(p['paid_at']),
          label: 'Payment (${p['method']})',
          amount: -(p['amount'] as int))),
    ];
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${vendor.name} - Ledger')),
      body: Column(children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Outstanding',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Rs.${(vendor.outstanding / 100).toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.orange)),
                ])),
        Expanded(
            child: FutureBuilder<List<_LedgerEntry>>(
                future: _load(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final entries = snapshot.data!;
                  if (entries.isEmpty) {
                    return const Center(
                        child: Text('No activity yet',
                            style: TextStyle(color: Colors.grey)));
                  }
                  return ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (_, i) {
                        final e = entries[i];
                        final isBill = e.amount > 0;
                        return ListTile(
                            leading: Icon(
                                isBill
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: isBill ? Colors.red : Colors.green),
                            title: Text(e.label),
                            subtitle: Text(
                                '${e.date.day}/${e.date.month}/${e.date.year}'),
                            trailing: Text(
                                '${isBill ? '+' : '-'}Rs.${(e.amount.abs() / 100).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isBill ? Colors.red : Colors.green)));
                      });
                })),
      ]),
    );
  }
}
