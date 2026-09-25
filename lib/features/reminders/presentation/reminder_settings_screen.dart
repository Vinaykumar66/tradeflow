import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/reminder_rule.dart';
import '../data/reminder_repository.dart';

class ReminderSettingsScreen extends ConsumerWidget {
  const ReminderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Reminder Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Placeholder: {invoice_number}, {customer_name}, {amount}',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Reminder Rule'),
            onPressed: () => _showRuleEditor(context, ref, biz?.id ?? '')),
      ]),
    );
  }

  void _showRuleEditor(BuildContext context, WidgetRef ref, String bizId) {
    final offsetCtrl = TextEditingController(text: '3');
    final messageCtrl = TextEditingController(
        text: 'Hi {customer_name}, invoice {invoice_number} for '
            '{amount} is due. Please arrange payment.');
    var channel = kChannelWhatsapp;

    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
            builder: (ctx, setState) => AlertDialog(
                    title: const Text('New Reminder Rule'),
                    content: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      DropdownButtonFormField<String>(
                          value: channel,
                          decoration:
                              const InputDecoration(labelText: 'Channel'),
                          items: const [
                            DropdownMenuItem(
                                value: kChannelWhatsapp,
                                child: Text('WhatsApp')),
                            DropdownMenuItem(
                                value: kChannelEmail, child: Text('Email')),
                          ],
                          onChanged: (v) =>
                              setState(() => channel = v ?? channel)),
                      TextField(
                          controller: offsetCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText:
                                  'Days after due date(negative = before)')),
                      TextField(
                          controller: messageCtrl,
                          maxLines: 3,
                          decoration:
                              const InputDecoration(labelText: 'Message')),
                    ])),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: () {
                            ReminderRepository().saveRule(ReminderRule(
                                id: '',
                                businessId: bizId,
                                channel: channel,
                                offsetDays: int.tryParse(offsetCtrl.text) ?? 0,
                                messageTemplate: messageCtrl.text));
                            Navigator.pop(ctx);
                          },
                          child: const Text('Save')),
                    ])));
  }
}
