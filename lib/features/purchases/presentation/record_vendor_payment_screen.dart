import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/vendor.dart';

class RecordVendorPaymentScreen extends ConsumerStatefulWidget {
  final Vendor vendor;
  const RecordVendorPaymentScreen({super.key, required this.vendor});

  @override
  ConsumerState<RecordVendorPaymentScreen> createState() =>
      _RecordVendorPaymentScreenState();
}

class _RecordVendorPaymentScreenState
    extends ConsumerState<RecordVendorPaymentScreen> {
  final _amountCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  String _method = 'cash';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _amountCtrl.text = (widget.vendor.outstanding / 100).toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _refCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amount = ((double.tryParse(_amountCtrl.text) ?? 0) * 100).round();
    if (amount <= 0) return;

    final biz = ref.read(activeBusinessProvider).asData?.value;
    final uid = ref.read(currentSupabaseUserProvider)?.id;
    if (biz == null) return;

    setState(() {
      _saving = true;
    });

    try {
      await supabase.from('vendor_payments').insert({
        'business_id': biz.id,
        'vendor_id': widget.vendor.id,
        'amount': amount,
        'method': _method,
        'reference': _refCtrl.text.trim().isEmpty ? null : _refCtrl.text.trim(),
        'created_by': uid,
      });

      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to save payment: $e'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted)
        setState(() {
          _saving = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Vendor')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Outstanding',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          '₹. ${(widget.vendor.outstanding / 100).toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ]))),
        const SizedBox(height: 20),
        TextFormField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Payment Amount')),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
            initialValue: _method,
            decoration: const InputDecoration(labelText: 'Payment Method'),
            items: const [
              DropdownMenuItem(value: 'cash', child: Text('Cash')),
              DropdownMenuItem(value: 'upi', child: Text('UPI')),
              DropdownMenuItem(value: 'bank', child: Text('Bank Transfer')),
              DropdownMenuItem(value: 'cheque', child: Text('Cheque')),
            ],
            onChanged: (v) => setState(() => _method = v ?? _method)),
        const SizedBox(height: 16),
        TextFormField(
            controller: _refCtrl,
            decoration:
                const InputDecoration(labelText: 'Reference(optional)')),
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
