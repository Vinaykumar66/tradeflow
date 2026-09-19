import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../features/business/application/business_providers.dart';
import '../application/reminder_providers.dart';
import '../data/reminder_repository.dart';

class ReminderQueueScreen extends ConsumerWidget {
  const ReminderQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueAsync = ref.watch(whatsappQueueProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('WhatsApp Reminders')),
        body: queueAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (queue) => queue.isEmpty
                ? const Center(
                    child: Text('No reminders due today',
                        style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: queue.length,
                    itemBuilder: (_, i) {
                      final item = queue[i];
                      return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(item.invoice.customerName ?? '-'),
                            subtitle: Text(item.invoice.invoiceNumber),
                            trailing: ElevatedButton.icon(
                                icon: const Icon(Icons.send_outlined, size: 16),
                                onPressed: () => _send(context, ref, item),
                                label: const Text('Send')),
                          ));
                    })));
  }

  Future<void> _send(
      BuildContext context, WidgetRef ref, DueReminder item) async {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    await Share.share(item.message);
    await ReminderRepository().logAttempt(
        businessId: biz?.id ?? '',
        invoiceId: item.invoice.id,
        customerId: item.invoice.customerId,
        channel: 'whatsapp');
    ref.invalidate(whatsappQueueProvider);
  }
}
