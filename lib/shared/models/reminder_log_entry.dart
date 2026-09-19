import 'package:freezed_annotation/freezed_annotation.dart';
part 'reminder_log_entry.freezed.dart';
part 'reminder_log_entry.g.dart';

@freezed
abstract class ReminderLogEntry with _$ReminderLogEntry {
  const factory ReminderLogEntry({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'invoice_id') String? invoiceId,
    @JsonKey(name: 'customer_id') String? customerId,
    required String channel,
    @Default('sent') String status,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'sent_at') DateTime? sentAt,
  }) = _ReminderLogEntry;

  factory ReminderLogEntry.fromJson(Map<String, dynamic> json) =>
      _$ReminderLogEntryFromJson(json);
}
