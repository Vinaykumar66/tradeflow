// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReminderRule _$ReminderRuleFromJson(Map<String, dynamic> json) {
  return _ReminderRule.fromJson(json);
}

/// @nodoc
mixin _$ReminderRule {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  @JsonKey(name: 'offset_days')
  int get offsetDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_template')
  String get messageTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this ReminderRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReminderRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderRuleCopyWith<ReminderRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderRuleCopyWith<$Res> {
  factory $ReminderRuleCopyWith(
          ReminderRule value, $Res Function(ReminderRule) then) =
      _$ReminderRuleCopyWithImpl<$Res, ReminderRule>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String channel,
      @JsonKey(name: 'offset_days') int offsetDays,
      @JsonKey(name: 'message_template') String messageTemplate,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$ReminderRuleCopyWithImpl<$Res, $Val extends ReminderRule>
    implements $ReminderRuleCopyWith<$Res> {
  _$ReminderRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? channel = null,
    Object? offsetDays = null,
    Object? messageTemplate = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      offsetDays: null == offsetDays
          ? _value.offsetDays
          : offsetDays // ignore: cast_nullable_to_non_nullable
              as int,
      messageTemplate: null == messageTemplate
          ? _value.messageTemplate
          : messageTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderRuleImplCopyWith<$Res>
    implements $ReminderRuleCopyWith<$Res> {
  factory _$$ReminderRuleImplCopyWith(
          _$ReminderRuleImpl value, $Res Function(_$ReminderRuleImpl) then) =
      __$$ReminderRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      String channel,
      @JsonKey(name: 'offset_days') int offsetDays,
      @JsonKey(name: 'message_template') String messageTemplate,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$ReminderRuleImplCopyWithImpl<$Res>
    extends _$ReminderRuleCopyWithImpl<$Res, _$ReminderRuleImpl>
    implements _$$ReminderRuleImplCopyWith<$Res> {
  __$$ReminderRuleImplCopyWithImpl(
      _$ReminderRuleImpl _value, $Res Function(_$ReminderRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? channel = null,
    Object? offsetDays = null,
    Object? messageTemplate = null,
    Object? isActive = null,
  }) {
    return _then(_$ReminderRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      offsetDays: null == offsetDays
          ? _value.offsetDays
          : offsetDays // ignore: cast_nullable_to_non_nullable
              as int,
      messageTemplate: null == messageTemplate
          ? _value.messageTemplate
          : messageTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderRuleImpl implements _ReminderRule {
  const _$ReminderRuleImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      required this.channel,
      @JsonKey(name: 'offset_days') required this.offsetDays,
      @JsonKey(name: 'message_template') required this.messageTemplate,
      @JsonKey(name: 'is_active') this.isActive = true});

  factory _$ReminderRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderRuleImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  final String channel;
  @override
  @JsonKey(name: 'offset_days')
  final int offsetDays;
  @override
  @JsonKey(name: 'message_template')
  final String messageTemplate;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'ReminderRule(id: $id, businessId: $businessId, channel: $channel, offsetDays: $offsetDays, messageTemplate: $messageTemplate, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.offsetDays, offsetDays) ||
                other.offsetDays == offsetDays) &&
            (identical(other.messageTemplate, messageTemplate) ||
                other.messageTemplate == messageTemplate) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, businessId, channel,
      offsetDays, messageTemplate, isActive);

  /// Create a copy of ReminderRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderRuleImplCopyWith<_$ReminderRuleImpl> get copyWith =>
      __$$ReminderRuleImplCopyWithImpl<_$ReminderRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderRuleImplToJson(
      this,
    );
  }
}

abstract class _ReminderRule implements ReminderRule {
  const factory _ReminderRule(
      {required final String id,
      @JsonKey(name: 'business_id') required final String businessId,
      required final String channel,
      @JsonKey(name: 'offset_days') required final int offsetDays,
      @JsonKey(name: 'message_template') required final String messageTemplate,
      @JsonKey(name: 'is_active') final bool isActive}) = _$ReminderRuleImpl;

  factory _ReminderRule.fromJson(Map<String, dynamic> json) =
      _$ReminderRuleImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  String get channel;
  @override
  @JsonKey(name: 'offset_days')
  int get offsetDays;
  @override
  @JsonKey(name: 'message_template')
  String get messageTemplate;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of ReminderRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderRuleImplCopyWith<_$ReminderRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
