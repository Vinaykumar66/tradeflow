import '../../../core/supabase/supabase_client.dart';
import '../../../shared/models/reminder_rule.dart';
import '../../../shared/models/reminder_log_entry.dart';

class ReminderRepository {
  Stream<List<ReminderRule>> streamRules(String businessId) {
    return supabase
        .from('reminder_rules')
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .map((rows) => rows.map(ReminderRule.fromJson).toList());
  }

  Future<void> saveRule(ReminderRule rule) async {
    final map = {
      'business_id': rule.businessId,
      'channel': rule.channel,
      'offset_days': rule.offsetDays,
      'message_template': rule.messageTemplate,
      'is_active': rule.isActive,
    };
    if (rule.id.isEmpty) {
      await supabase.from('reminder_rules').insert(map);
    } else {
      await supabase.from('reminder_rules').update(map).eq('id', rule.id);
    }
  }

  Future<void> logAttempt({
    required String businessId,
    String? invoiceId,
    String? customerId,
    required String channel,
    String status = 'sent',
    String? errorMessage,
  }) async {
    await supabase.from('reminder_log').insert({
      'business_id': businessId,
      'invoice_id': invoiceId,
      'customer_id': customerId,
      'channel': channel,
      'status': status,
      'error_message': errorMessage,
    });
  }

  Stream<List<ReminderLogEntry>> streamLog(String businessId) {
    return supabase
        .from('reminder_log')
        .stream(primaryKey: ['id'])
        .eq('business_id', businessId)
        .order('sent_at', ascending: false)
        .map((rows) => rows.map(ReminderLogEntry.fromJson).toList());
  }
}
