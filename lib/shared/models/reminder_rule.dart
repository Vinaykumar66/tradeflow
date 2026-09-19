import 'package:freezed_annotation/freezed_annotation.dart';
part 'reminder_rule.freezed.dart';
part 'reminder_rule.g.dart';

const kChannelWhatsapp = 'whatsapp';
const kChannelEmail = 'email';

@freezed
abstract class ReminderRule with _$ReminderRule {
  const factory ReminderRule({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    required String channel,
    @JsonKey(name: 'offset_days') required int offsetDays,
    @JsonKey(name: 'message_template') required String messageTemplate,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _ReminderRule;

  factory ReminderRule.fromJson(Map<String, dynamic> json) =>
      _$ReminderRuleFromJson(json);
}
