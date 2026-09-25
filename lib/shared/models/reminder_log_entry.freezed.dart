// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReminderLogEntry _$ReminderLogEntryFromJson(Map<String, dynamic> json) {
  return _ReminderLogEntry.fromJson(json);
}

/// @nodoc
mixin _$ReminderLogEntry {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'business_id')
  String get businessId => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_id')
  String? get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'customer_id')
  String? get customerId => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_message')
  String? get errorMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt => throw _privateConstructorUsedError;

  /// Serializes this ReminderLogEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReminderLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReminderLogEntryCopyWith<ReminderLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReminderLogEntryCopyWith<$Res> {
  factory $ReminderLogEntryCopyWith(
          ReminderLogEntry value, $Res Function(ReminderLogEntry) then) =
      _$ReminderLogEntryCopyWithImpl<$Res, ReminderLogEntry>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'invoice_id') String? invoiceId,
      @JsonKey(name: 'customer_id') String? customerId,
      String channel,
      String status,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'sent_at') DateTime? sentAt});
}

/// @nodoc
class _$ReminderLogEntryCopyWithImpl<$Res, $Val extends ReminderLogEntry>
    implements $ReminderLogEntryCopyWith<$Res> {
  _$ReminderLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReminderLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? invoiceId = freezed,
    Object? customerId = freezed,
    Object? channel = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? sentAt = freezed,
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
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReminderLogEntryImplCopyWith<$Res>
    implements $ReminderLogEntryCopyWith<$Res> {
  factory _$$ReminderLogEntryImplCopyWith(_$ReminderLogEntryImpl value,
          $Res Function(_$ReminderLogEntryImpl) then) =
      __$$ReminderLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'business_id') String businessId,
      @JsonKey(name: 'invoice_id') String? invoiceId,
      @JsonKey(name: 'customer_id') String? customerId,
      String channel,
      String status,
      @JsonKey(name: 'error_message') String? errorMessage,
      @JsonKey(name: 'sent_at') DateTime? sentAt});
}

/// @nodoc
class __$$ReminderLogEntryImplCopyWithImpl<$Res>
    extends _$ReminderLogEntryCopyWithImpl<$Res, _$ReminderLogEntryImpl>
    implements _$$ReminderLogEntryImplCopyWith<$Res> {
  __$$ReminderLogEntryImplCopyWithImpl(_$ReminderLogEntryImpl _value,
      $Res Function(_$ReminderLogEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReminderLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? businessId = null,
    Object? invoiceId = freezed,
    Object? customerId = freezed,
    Object? channel = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? sentAt = freezed,
  }) {
    return _then(_$ReminderLogEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessId: null == businessId
          ? _value.businessId
          : businessId // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceId: freezed == invoiceId
          ? _value.invoiceId
          : invoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReminderLogEntryImpl implements _ReminderLogEntry {
  const _$ReminderLogEntryImpl(
      {required this.id,
      @JsonKey(name: 'business_id') required this.businessId,
      @JsonKey(name: 'invoice_id') this.invoiceId,
      @JsonKey(name: 'customer_id') this.customerId,
      required this.channel,
      this.status = 'sent',
      @JsonKey(name: 'error_message') this.errorMessage,
      @JsonKey(name: 'sent_at') this.sentAt});

  factory _$ReminderLogEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReminderLogEntryImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'business_id')
  final String businessId;
  @override
  @JsonKey(name: 'invoice_id')
  final String? invoiceId;
  @override
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @override
  final String channel;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'error_message')
  final String? errorMessage;
  @override
  @JsonKey(name: 'sent_at')
  final DateTime? sentAt;

  @override
  String toString() {
    return 'ReminderLogEntry(id: $id, businessId: $businessId, invoiceId: $invoiceId, customerId: $customerId, channel: $channel, status: $status, errorMessage: $errorMessage, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReminderLogEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.businessId, businessId) ||
                other.businessId == businessId) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, businessId, invoiceId,
      customerId, channel, status, errorMessage, sentAt);

  /// Create a copy of ReminderLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReminderLogEntryImplCopyWith<_$ReminderLogEntryImpl> get copyWith =>
      __$$ReminderLogEntryImplCopyWithImpl<_$ReminderLogEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReminderLogEntryImplToJson(
      this,
    );
  }
}

abstract class _ReminderLogEntry implements ReminderLogEntry {
  const factory _ReminderLogEntry(
          {required final String id,
          @JsonKey(name: 'business_id') required final String businessId,
          @JsonKey(name: 'invoice_id') final String? invoiceId,
          @JsonKey(name: 'customer_id') final String? customerId,
          required final String channel,
          final String status,
          @JsonKey(name: 'error_message') final String? errorMessage,
          @JsonKey(name: 'sent_at') final DateTime? sentAt}) =
      _$ReminderLogEntryImpl;

  factory _ReminderLogEntry.fromJson(Map<String, dynamic> json) =
      _$ReminderLogEntryImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'business_id')
  String get businessId;
  @override
  @JsonKey(name: 'invoice_id')
  String? get invoiceId;
  @override
  @JsonKey(name: 'customer_id')
  String? get customerId;
  @override
  String get channel;
  @override
  String get status;
  @override
  @JsonKey(name: 'error_message')
  String? get errorMessage;
  @override
  @JsonKey(name: 'sent_at')
  DateTime? get sentAt;

  /// Create a copy of ReminderLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReminderLogEntryImplCopyWith<_$ReminderLogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
