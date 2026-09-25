import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/business/application/business_providers.dart';
import '../data/reminder_repository.dart';

final reminderHistoryProvider = StreamProvider((ref) {
  final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;
  if (bizId == null) return const Stream.empty();
  return ReminderRepository().streamLog(bizId);
});

class ReminderHistoryScreen extends ConsumerWidget {
  const ReminderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logAsync = ref.watch(reminderHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Reminder History')),
      body: logAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (log) => ListView.builder(
            itemCount: log.length,
            itemBuilder: (_, i) {
              final entry = log[i];
              return ListTile(
                  leading: Icon(entry.channel == 'whatsapp'
                      ? Icons.chat_outlined
                      : Icons.email_outlined),
                  title: Text(entry.channel.toUpperCase()),
                  subtitle: Text(entry.status),
                  trailing:
                      Text(entry.sentAt?.toString().split('.').first ?? ''));
            }),
      ),
    );
  }
}
