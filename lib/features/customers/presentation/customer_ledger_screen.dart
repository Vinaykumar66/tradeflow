import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/table_constants.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/models/customer.dart';
import '../../business/application/business_providers.dart';

// Unified ledger entry (invoice or payment)
class LedgerEntry {
  final String id;
  final String type; // 'invoice' or 'payment'
  final String reference; // invoice number or 'Payment'
  final DateTime date;
  final int amount; // in paise
  final String status;
  const LedgerEntry(
      {required this.id,
      required this.type,
      required this.reference,
      required this.date,
      required this.amount,
      required this.status});
}

class CustomerLedgerScreen extends ConsumerWidget {
  final Customer customer;
  const CustomerLedgerScreen({super.key, required this.customer});

  Future<List<LedgerEntry>> _fetchLedger() async {
    // Fetch invoices for this customer
    final invoices = await supabase
        .from(SupabaseTables.invoices)
        .select()
        .eq('customer_id', customer.id)
        .neq('status', 'cancelled')
        .order('invoice_date', ascending: false);

    // Fetch payments for this customer
    final payments = await supabase
        .from(SupabaseTables.payments)
        .select()
        .eq('customer_id', customer.id)
        .order('paid_at', ascending: false);

    // Merge into a single list
    final entries = <LedgerEntry>[];

    for (final inv in invoices) {
      entries.add(LedgerEntry(
        id: inv['id'],
        type: 'invoice',
        reference: inv['invoice_number'] ?? 'Invoice',
        date: DateTime.parse(inv['invoice_date']),
        amount: inv['total'] as int,
        status: inv['status'] ?? 'draft',
      ));
    }

    for (final pmt in payments) {
      entries.add(LedgerEntry(
        id: pmt['id'],
        type: 'payment',
        reference: 'Payment (${pmt['method'] ?? 'cash'})',
        date: DateTime.parse(pmt['paid_at']),
        amount: pmt['amount'] as int,
        status: 'paid',
      ));
    }

    // Sort by date descending (newest first)
    entries.sort((a, b) => b.date.compareTo(a.date));
    return entries;
  }

  Future<void> _sendWhatsAppReminder(BuildContext context) async {
    if (customer.phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No phone number for this customer')));
      return;
    }

    // Pre-formatted WhatsApp payment reminder message
    final message = 'Dear ${customer.name},\n\n'
        'This is a gentle reminder that you have an outstanding '
        'balance of ${customer.formattedOutstanding}.\n\n'
        '${customer.paymentTerms > 0 ? 'Payment terms: Net ${customer.paymentTerms} days.\n\n' : ''}'
        'Please arrange payment at your earliest convenience.\n\n'
        'Thank you for your business!';

    // Share via WhatsApp or any messaging app
    await Share.share(
      message,
      subject: 'Payment Reminder',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym =
        ref.watch(activeBusinessProvider).asData?.value?.currencySymbol ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('${customer.name} - Ledger'),
        actions: [
          // WhatsApp reminder
          IconButton(
              icon: const Icon(Icons.send_outlined),
              tooltip: 'Send payment reminder',
              onPressed: () => _sendWhatsAppReminder(context)),
        ],
      ),
      body: Column(children: [
        // Balance summary card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: customer.isOverCreditLimit
              ? AppColors.alertRed.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.05),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Total Outstanding', style: AppTextStyles.bodySmall),
              Text(customer.formattedOutstanding(sym),
                  style: AppTextStyles.amountLarge.copyWith(
                      color: customer.isOverCreditLimit
                          ? AppColors.alertRed
                          : AppColors.primary)),
            ]),
          ]),
        ),
        // Ledger entries
        Expanded(
            child: FutureBuilder<List<LedgerEntry>>(
          future: _fetchLedger(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            if (snap.hasError)
              return Center(child: Text('Error: ${snap.error}'));
            final entries = snap.data ?? [];
            if (entries.isEmpty)
              return const Center(child: Text('No transactions yet'));

            // Calculate running balance
            int runningBalance = 0;
            // Sum all invoices first for running balance calc
            for (final e in entries.reversed) {
              if (e.type == 'invoice') runningBalance += e.amount;
              if (e.type == 'payment') runningBalance -= e.amount;
            }

            return ListView.separated(
              itemCount: entries.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final entry = entries[i];
                final isInvoice = entry.type == 'invoice';
                return ListTile(
                  leading: CircleAvatar(
                      backgroundColor: isInvoice
                          ? AppColors.alertRed.withValues(alpha: 0.1)
                          : AppColors.alertGreen.withValues(alpha: 0.1),
                      child: Icon(
                          isInvoice
                              ? Icons.receipt_outlined
                              : Icons.payments_outlined,
                          color: isInvoice
                              ? AppColors.alertRed
                              : AppColors.alertGreen,
                          size: 20)),
                  title: Text(entry.reference,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                      '${entry.date.day}/${entry.date.month}/${entry.date.year}'
                      ' - ${entry.status}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: Text(
                      '${isInvoice ? '+' : '-'}'
                      '$sym ${(entry.amount / 100).toStringAsFixed(2)}', // sym from activeBusinessProvider
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isInvoice
                              ? AppColors.alertRed
                              : AppColors.alertGreen)),
                );
              },
            );
          },
        )),
      ]),
    );
  }
}
