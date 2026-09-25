// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_log_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderLogEntryImpl _$$ReminderLogEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ReminderLogEntryImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      invoiceId: json['invoice_id'] as String?,
      customerId: json['customer_id'] as String?,
      channel: json['channel'] as String,
      status: json['status'] as String? ?? 'sent',
      errorMessage: json['error_message'] as String?,
      sentAt: json['sent_at'] == null
          ? null
          : DateTime.parse(json['sent_at'] as String),
    );

Map<String, dynamic> _$$ReminderLogEntryImplToJson(
        _$ReminderLogEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'invoice_id': instance.invoiceId,
      'customer_id': instance.customerId,
      'channel': instance.channel,
      'status': instance.status,
      'error_message': instance.errorMessage,
      'sent_at': instance.sentAt?.toIso8601String(),
    };
