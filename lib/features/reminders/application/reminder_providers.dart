import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tradeflow/core/interfaces/i_einvoice_provider.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';
part 'reminder_providers.g.dart';

class DueReminder {
  final Invoice invoice;
  final String channel;
  final String message;
  const DueReminder(
      {required this.invoice, required this.channel, required this.message});
}

@riverpod
Future<List<DueReminder>> whatsappQueue(WhatsappQueueRef ref) async {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) return [];
  final rules = await supabase
      .from('reminder_rules')
      .select()
      .eq('business_id', bizId)
      .eq('channel', 'whatsapp')
      .eq('is_active', true);
  if (rules.isEmpty) return [];

  final invoices = await supabase
      .from('invoices')
      .select()
      .eq('business_id', bizId)
      .eq('document_type', kDocTypeInvoice)
      .not('status', 'in', '(paid, cancelled)');

  final due = <DueReminder>[];
  final today = DateTime.now();
  for (final row in invoices) {
    final inv = Invoice.fromJson(row);
    if (inv.dueDate == null) continue;
    for (final ruleRow in rules) {
      final offset = ruleRow['offset_days'] as int;
      final target = inv.dueDate!.add(Duration(days: offset));
      final sameDay = target.year == today.year &&
          target.month == today.month &&
          target.day == today.day;
      if (!sameDay) continue;
      final template = ruleRow['message_template'] as String;
      final message = template
          .replaceAll('{invoice_number}', inv.invoiceNumber)
          .replaceAll('{amount}', inv.formattedBalanceDue)
          .replaceAll('{customer_name}', inv.customerName ?? '');

      due.add(DueReminder(invoice: inv, channel: 'whatsapp', message: message));
    }
  }
}
