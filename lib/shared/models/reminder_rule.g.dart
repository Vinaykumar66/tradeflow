// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReminderRuleImpl _$$ReminderRuleImplFromJson(Map<String, dynamic> json) =>
    _$ReminderRuleImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      channel: json['channel'] as String,
      offsetDays: (json['offset_days'] as num).toInt(),
      messageTemplate: json['message_template'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$ReminderRuleImplToJson(_$ReminderRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'channel': instance.channel,
      'offset_days': instance.offsetDays,
      'message_template': instance.messageTemplate,
      'is_active': instance.isActive,
    };
