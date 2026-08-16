import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../shared/models/invoice.dart';
import '../../../features/auth/application/auth_providers.dart';

class RecordPaymentScreen extends ConsumerStatefulWidget {
  final Invoice invoice;
  const RecordPaymentScreen({super.key, required this.invoice});
  @override
  ConsumerState<RecordPaymentScreen> createState() =>
      _RecordPaymentScreenState();
}

class _RecordPaymentScreenState extends ConsumerState<RecordPaymentScreen> {
  final _amtCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  String _method = 'cash';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Default to full balance due
    final balance = widget.invoice.balanceDue;
    _amtCtrl.text = (balance / 100).toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = ((double.tryParse(_amtCtrl.text) ?? 0) * 100).round();
    if (amount <= 0) return;
    setState(() => _saving = true);
    try {
      final inv = widget.invoice;
      final uid = ref.read(currentSupabaseUserProvider)?.id;
      // Insert into payments table
      await supabase.from('payments').insert({
        'business_id': inv.businessId,
        'invoice_id': inv.id,
        'customer_id': inv.customerId,
        'amount': amount,
        'method': _method,
        'reference': _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text,
        'paid_at': DateTime.now().toIso8601String(),
        'created_by': uid,
      });
      // Update invoice amount_paid and status
      final newPaid = inv.amountPaid + amount;
      final newStatus = newPaid >= inv.total ? kStatusPaid : kStatusPartial;
      await supabase.from('invoices').update({
        'amount_paid': newPaid,
        'status': newStatus,
      }).eq('id', inv.id);
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inv = widget.invoice;
    final fmt = (int v) => CurrencyFormatter.format(v,
        sym: inv.currencySymbol, lakh: inv.useLakhFormat);
    return Scaffold(
      appBar: AppBar(title: const Text('Record Payment')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Balance info
        Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Invoice Total'),
                        Text(fmt(inv.total),
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Amount Paid'),
                        Text(fmt(inv.amountPaid))
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Balance Due',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(fmt(inv.balanceDue),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange))
                      ]),
                ]))),
        const SizedBox(height: 20),
        // Payment amount
        TextFormField(
            controller: _amtCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Payment Amount (${inv.currencyCode})',
                prefixText: '${inv.currencySymbol} ')),
        const SizedBox(height: 16),
        // Payment method
        DropdownButtonFormField<String>(
            value: _method,
            decoration: const InputDecoration(labelText: 'Payment Method'),
            items: const [
              DropdownMenuItem(value: 'cash', child: Text('Cash')),
              DropdownMenuItem(value: 'upi', child: Text('UPI')),
              DropdownMenuItem(value: 'bank', child: Text('Bank Transfer')),
              DropdownMenuItem(value: 'card', child: Text('Card')),
              DropdownMenuItem(value: 'cheque', child: Text('Cheque')),
            ],
            onChanged: (v) => setState(() => _method = v ?? _method)),
        const SizedBox(height: 16),
        TextFormField(
            controller: _noteCtrl,
            decoration:
                const InputDecoration(labelText: 'Reference (optional)')),
        const SizedBox(height: 24),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Record Payment'))),
      ]),
    );
  }
}
