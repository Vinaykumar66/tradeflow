// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return _Business.fromJson(json);
}

/// @nodoc
mixin _$Business {
// Core — required
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError; // Owner
  @JsonKey(name: 'owner_uid')
  String? get ownerUid =>
      throw _privateConstructorUsedError; // Contact details — all nullable
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get pincode =>
      throw _privateConstructorUsedError; // Tax identifiers — nullable
  String? get gstin => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_number')
  String? get taxNumber => throw _privateConstructorUsedError; // Branding
  @JsonKey(name: 'logo_url')
  String? get logoUrl =>
      throw _privateConstructorUsedError; // Currency — database has BOTH 'currency' and 'currency_code'
// Use currency_code as the primary field
  @JsonKey(name: 'currency_code')
  String get currencyCode =>
      throw _privateConstructorUsedError; // Also map 'currency' column (legacy column in your DB)
  @JsonKey(name: 'currency')
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'currency_symbol')
  String get currencySymbol =>
      throw _privateConstructorUsedError; // Country code — database has BOTH 'country' and 'country_code'
  @JsonKey(name: 'country_code')
  String get countryCode => throw _privateConstructorUsedError; // Tax settings
  @JsonKey(name: 'tax_label')
  String get taxLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_tax_rate')
  double get defaultTaxRate =>
      throw _privateConstructorUsedError; // Number formatting
  @JsonKey(name: 'date_format')
  String get dateFormat => throw _privateConstructorUsedError;
  @JsonKey(name: 'use_lakh_format')
  bool get useLakhFormat =>
      throw _privateConstructorUsedError; // Invoice settings
  @JsonKey(name: 'invoice_prefix')
  String get invoicePrefix => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_invoice_number')
  int get nextInvoiceNumber =>
      throw _privateConstructorUsedError; // License / subscription
  @JsonKey(name: 'license_tier')
  String get licenseTierValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'tier_expires_at')
  DateTime? get tierExpiresAt =>
      throw _privateConstructorUsedError; // Operator overrides — all nullable
  @JsonKey(name: 'email_override')
  bool? get emailOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'cron_reminder_override')
  bool? get cronReminderOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_limit_override')
  int? get invoiceLimitOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_limit_override')
  int? get userLimitOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'storage_limit_override')
  int? get storageLimitOverride => throw _privateConstructorUsedError;
  @JsonKey(name: 'operator_note')
  String? get operatorNote => throw _privateConstructorUsedError; // Status
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Business to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessCopyWith<Business> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessCopyWith<$Res> {
  factory $BusinessCopyWith(Business value, $Res Function(Business) then) =
      _$BusinessCopyWithImpl<$Res, Business>;
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'owner_uid') String? ownerUid,
      String? email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? country,
      String? pincode,
      String? gstin,
      @JsonKey(name: 'tax_number') String? taxNumber,
      @JsonKey(name: 'logo_url') String? logoUrl,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'currency') String currency,
      @JsonKey(name: 'currency_symbol') String currencySymbol,
      @JsonKey(name: 'country_code') String countryCode,
      @JsonKey(name: 'tax_label') String taxLabel,
      @JsonKey(name: 'default_tax_rate') double defaultTaxRate,
      @JsonKey(name: 'date_format') String dateFormat,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      @JsonKey(name: 'invoice_prefix') String invoicePrefix,
      @JsonKey(name: 'next_invoice_number') int nextInvoiceNumber,
      @JsonKey(name: 'license_tier') String licenseTierValue,
      @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override') int? storageLimitOverride,
      @JsonKey(name: 'operator_note') String? operatorNote,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class _$BusinessCopyWithImpl<$Res, $Val extends Business>
    implements $BusinessCopyWith<$Res> {
  _$BusinessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerUid = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
    Object? gstin = freezed,
    Object? taxNumber = freezed,
    Object? logoUrl = freezed,
    Object? currencyCode = null,
    Object? currency = null,
    Object? currencySymbol = null,
    Object? countryCode = null,
    Object? taxLabel = null,
    Object? defaultTaxRate = null,
    Object? dateFormat = null,
    Object? useLakhFormat = null,
    Object? invoicePrefix = null,
    Object? nextInvoiceNumber = null,
    Object? licenseTierValue = null,
    Object? tierExpiresAt = freezed,
    Object? emailOverride = freezed,
    Object? cronReminderOverride = freezed,
    Object? invoiceLimitOverride = freezed,
    Object? userLimitOverride = freezed,
    Object? storageLimitOverride = freezed,
    Object? operatorNote = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: freezed == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      gstin: freezed == gstin
          ? _value.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      taxLabel: null == taxLabel
          ? _value.taxLabel
          : taxLabel // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTaxRate: null == defaultTaxRate
          ? _value.defaultTaxRate
          : defaultTaxRate // ignore: cast_nullable_to_non_nullable
              as double,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      useLakhFormat: null == useLakhFormat
          ? _value.useLakhFormat
          : useLakhFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      invoicePrefix: null == invoicePrefix
          ? _value.invoicePrefix
          : invoicePrefix // ignore: cast_nullable_to_non_nullable
              as String,
      nextInvoiceNumber: null == nextInvoiceNumber
          ? _value.nextInvoiceNumber
          : nextInvoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      licenseTierValue: null == licenseTierValue
          ? _value.licenseTierValue
          : licenseTierValue // ignore: cast_nullable_to_non_nullable
              as String,
      tierExpiresAt: freezed == tierExpiresAt
          ? _value.tierExpiresAt
          : tierExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailOverride: freezed == emailOverride
          ? _value.emailOverride
          : emailOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      cronReminderOverride: freezed == cronReminderOverride
          ? _value.cronReminderOverride
          : cronReminderOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      invoiceLimitOverride: freezed == invoiceLimitOverride
          ? _value.invoiceLimitOverride
          : invoiceLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      userLimitOverride: freezed == userLimitOverride
          ? _value.userLimitOverride
          : userLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      storageLimitOverride: freezed == storageLimitOverride
          ? _value.storageLimitOverride
          : storageLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      operatorNote: freezed == operatorNote
          ? _value.operatorNote
          : operatorNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessImplCopyWith<$Res>
    implements $BusinessCopyWith<$Res> {
  factory _$$BusinessImplCopyWith(
          _$BusinessImpl value, $Res Function(_$BusinessImpl) then) =
      __$$BusinessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      @JsonKey(name: 'owner_uid') String? ownerUid,
      String? email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? country,
      String? pincode,
      String? gstin,
      @JsonKey(name: 'tax_number') String? taxNumber,
      @JsonKey(name: 'logo_url') String? logoUrl,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'currency') String currency,
      @JsonKey(name: 'currency_symbol') String currencySymbol,
      @JsonKey(name: 'country_code') String countryCode,
      @JsonKey(name: 'tax_label') String taxLabel,
      @JsonKey(name: 'default_tax_rate') double defaultTaxRate,
      @JsonKey(name: 'date_format') String dateFormat,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      @JsonKey(name: 'invoice_prefix') String invoicePrefix,
      @JsonKey(name: 'next_invoice_number') int nextInvoiceNumber,
      @JsonKey(name: 'license_tier') String licenseTierValue,
      @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override') int? storageLimitOverride,
      @JsonKey(name: 'operator_note') String? operatorNote,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});
}

/// @nodoc
class __$$BusinessImplCopyWithImpl<$Res>
    extends _$BusinessCopyWithImpl<$Res, _$BusinessImpl>
    implements _$$BusinessImplCopyWith<$Res> {
  __$$BusinessImplCopyWithImpl(
      _$BusinessImpl _value, $Res Function(_$BusinessImpl) _then)
      : super(_value, _then);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ownerUid = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
    Object? gstin = freezed,
    Object? taxNumber = freezed,
    Object? logoUrl = freezed,
    Object? currencyCode = null,
    Object? currency = null,
    Object? currencySymbol = null,
    Object? countryCode = null,
    Object? taxLabel = null,
    Object? defaultTaxRate = null,
    Object? dateFormat = null,
    Object? useLakhFormat = null,
    Object? invoicePrefix = null,
    Object? nextInvoiceNumber = null,
    Object? licenseTierValue = null,
    Object? tierExpiresAt = freezed,
    Object? emailOverride = freezed,
    Object? cronReminderOverride = freezed,
    Object? invoiceLimitOverride = freezed,
    Object? userLimitOverride = freezed,
    Object? storageLimitOverride = freezed,
    Object? operatorNote = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$BusinessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: freezed == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      pincode: freezed == pincode
          ? _value.pincode
          : pincode // ignore: cast_nullable_to_non_nullable
              as String?,
      gstin: freezed == gstin
          ? _value.gstin
          : gstin // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      currencySymbol: null == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      countryCode: null == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String,
      taxLabel: null == taxLabel
          ? _value.taxLabel
          : taxLabel // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTaxRate: null == defaultTaxRate
          ? _value.defaultTaxRate
          : defaultTaxRate // ignore: cast_nullable_to_non_nullable
              as double,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      useLakhFormat: null == useLakhFormat
          ? _value.useLakhFormat
          : useLakhFormat // ignore: cast_nullable_to_non_nullable
              as bool,
      invoicePrefix: null == invoicePrefix
          ? _value.invoicePrefix
          : invoicePrefix // ignore: cast_nullable_to_non_nullable
              as String,
      nextInvoiceNumber: null == nextInvoiceNumber
          ? _value.nextInvoiceNumber
          : nextInvoiceNumber // ignore: cast_nullable_to_non_nullable
              as int,
      licenseTierValue: null == licenseTierValue
          ? _value.licenseTierValue
          : licenseTierValue // ignore: cast_nullable_to_non_nullable
              as String,
      tierExpiresAt: freezed == tierExpiresAt
          ? _value.tierExpiresAt
          : tierExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailOverride: freezed == emailOverride
          ? _value.emailOverride
          : emailOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      cronReminderOverride: freezed == cronReminderOverride
          ? _value.cronReminderOverride
          : cronReminderOverride // ignore: cast_nullable_to_non_nullable
              as bool?,
      invoiceLimitOverride: freezed == invoiceLimitOverride
          ? _value.invoiceLimitOverride
          : invoiceLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      userLimitOverride: freezed == userLimitOverride
          ? _value.userLimitOverride
          : userLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      storageLimitOverride: freezed == storageLimitOverride
          ? _value.storageLimitOverride
          : storageLimitOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      operatorNote: freezed == operatorNote
          ? _value.operatorNote
          : operatorNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessImpl implements _Business {
  const _$BusinessImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'owner_uid') this.ownerUid,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.gstin,
      @JsonKey(name: 'tax_number') this.taxNumber,
      @JsonKey(name: 'logo_url') this.logoUrl,
      @JsonKey(name: 'currency_code') this.currencyCode = 'INR',
      @JsonKey(name: 'currency') this.currency = 'INR',
      @JsonKey(name: 'currency_symbol') this.currencySymbol = 'Rs.',
      @JsonKey(name: 'country_code') this.countryCode = 'IN',
      @JsonKey(name: 'tax_label') this.taxLabel = 'GST',
      @JsonKey(name: 'default_tax_rate') this.defaultTaxRate = 18.0,
      @JsonKey(name: 'date_format') this.dateFormat = 'DD/MM/YYYY',
      @JsonKey(name: 'use_lakh_format') this.useLakhFormat = true,
      @JsonKey(name: 'invoice_prefix') this.invoicePrefix = 'INV',
      @JsonKey(name: 'next_invoice_number') this.nextInvoiceNumber = 1,
      @JsonKey(name: 'license_tier') this.licenseTierValue = 'starter',
      @JsonKey(name: 'tier_expires_at') this.tierExpiresAt,
      @JsonKey(name: 'email_override') this.emailOverride,
      @JsonKey(name: 'cron_reminder_override') this.cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') this.invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') this.userLimitOverride,
      @JsonKey(name: 'storage_limit_override') this.storageLimitOverride,
      @JsonKey(name: 'operator_note') this.operatorNote,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt});

  factory _$BusinessImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessImplFromJson(json);

// Core — required
  @override
  final String id;
  @override
  final String name;
// Owner
  @override
  @JsonKey(name: 'owner_uid')
  final String? ownerUid;
// Contact details — all nullable
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? country;
  @override
  final String? pincode;
// Tax identifiers — nullable
  @override
  final String? gstin;
  @override
  @JsonKey(name: 'tax_number')
  final String? taxNumber;
// Branding
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
// Currency — database has BOTH 'currency' and 'currency_code'
// Use currency_code as the primary field
  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;
// Also map 'currency' column (legacy column in your DB)
  @override
  @JsonKey(name: 'currency')
  final String currency;
  @override
  @JsonKey(name: 'currency_symbol')
  final String currencySymbol;
// Country code — database has BOTH 'country' and 'country_code'
  @override
  @JsonKey(name: 'country_code')
  final String countryCode;
// Tax settings
  @override
  @JsonKey(name: 'tax_label')
  final String taxLabel;
  @override
  @JsonKey(name: 'default_tax_rate')
  final double defaultTaxRate;
// Number formatting
  @override
  @JsonKey(name: 'date_format')
  final String dateFormat;
  @override
  @JsonKey(name: 'use_lakh_format')
  final bool useLakhFormat;
// Invoice settings
  @override
  @JsonKey(name: 'invoice_prefix')
  final String invoicePrefix;
  @override
  @JsonKey(name: 'next_invoice_number')
  final int nextInvoiceNumber;
// License / subscription
  @override
  @JsonKey(name: 'license_tier')
  final String licenseTierValue;
  @override
  @JsonKey(name: 'tier_expires_at')
  final DateTime? tierExpiresAt;
// Operator overrides — all nullable
  @override
  @JsonKey(name: 'email_override')
  final bool? emailOverride;
  @override
  @JsonKey(name: 'cron_reminder_override')
  final bool? cronReminderOverride;
  @override
  @JsonKey(name: 'invoice_limit_override')
  final int? invoiceLimitOverride;
  @override
  @JsonKey(name: 'user_limit_override')
  final int? userLimitOverride;
  @override
  @JsonKey(name: 'storage_limit_override')
  final int? storageLimitOverride;
  @override
  @JsonKey(name: 'operator_note')
  final String? operatorNote;
// Status
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Business(id: $id, name: $name, ownerUid: $ownerUid, email: $email, phone: $phone, address: $address, city: $city, state: $state, country: $country, pincode: $pincode, gstin: $gstin, taxNumber: $taxNumber, logoUrl: $logoUrl, currencyCode: $currencyCode, currency: $currency, currencySymbol: $currencySymbol, countryCode: $countryCode, taxLabel: $taxLabel, defaultTaxRate: $defaultTaxRate, dateFormat: $dateFormat, useLakhFormat: $useLakhFormat, invoicePrefix: $invoicePrefix, nextInvoiceNumber: $nextInvoiceNumber, licenseTierValue: $licenseTierValue, tierExpiresAt: $tierExpiresAt, emailOverride: $emailOverride, cronReminderOverride: $cronReminderOverride, invoiceLimitOverride: $invoiceLimitOverride, userLimitOverride: $userLimitOverride, storageLimitOverride: $storageLimitOverride, operatorNote: $operatorNote, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ownerUid, ownerUid) ||
                other.ownerUid == ownerUid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.gstin, gstin) || other.gstin == gstin) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.taxLabel, taxLabel) ||
                other.taxLabel == taxLabel) &&
            (identical(other.defaultTaxRate, defaultTaxRate) ||
                other.defaultTaxRate == defaultTaxRate) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.useLakhFormat, useLakhFormat) ||
                other.useLakhFormat == useLakhFormat) &&
            (identical(other.invoicePrefix, invoicePrefix) ||
                other.invoicePrefix == invoicePrefix) &&
            (identical(other.nextInvoiceNumber, nextInvoiceNumber) ||
                other.nextInvoiceNumber == nextInvoiceNumber) &&
            (identical(other.licenseTierValue, licenseTierValue) ||
                other.licenseTierValue == licenseTierValue) &&
            (identical(other.tierExpiresAt, tierExpiresAt) ||
                other.tierExpiresAt == tierExpiresAt) &&
            (identical(other.emailOverride, emailOverride) ||
                other.emailOverride == emailOverride) &&
            (identical(other.cronReminderOverride, cronReminderOverride) ||
                other.cronReminderOverride == cronReminderOverride) &&
            (identical(other.invoiceLimitOverride, invoiceLimitOverride) ||
                other.invoiceLimitOverride == invoiceLimitOverride) &&
            (identical(other.userLimitOverride, userLimitOverride) ||
                other.userLimitOverride == userLimitOverride) &&
            (identical(other.storageLimitOverride, storageLimitOverride) ||
                other.storageLimitOverride == storageLimitOverride) &&
            (identical(other.operatorNote, operatorNote) ||
                other.operatorNote == operatorNote) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        ownerUid,
        email,
        phone,
        address,
        city,
        state,
        country,
        pincode,
        gstin,
        taxNumber,
        logoUrl,
        currencyCode,
        currency,
        currencySymbol,
        countryCode,
        taxLabel,
        defaultTaxRate,
        dateFormat,
        useLakhFormat,
        invoicePrefix,
        nextInvoiceNumber,
        licenseTierValue,
        tierExpiresAt,
        emailOverride,
        cronReminderOverride,
        invoiceLimitOverride,
        userLimitOverride,
        storageLimitOverride,
        operatorNote,
        isActive,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      __$$BusinessImplCopyWithImpl<_$BusinessImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessImplToJson(
      this,
    );
  }
}

abstract class _Business implements Business {
  const factory _Business(
      {required final String id,
      required final String name,
      @JsonKey(name: 'owner_uid') final String? ownerUid,
      final String? email,
      final String? phone,
      final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? pincode,
      final String? gstin,
      @JsonKey(name: 'tax_number') final String? taxNumber,
      @JsonKey(name: 'logo_url') final String? logoUrl,
      @JsonKey(name: 'currency_code') final String currencyCode,
      @JsonKey(name: 'currency') final String currency,
      @JsonKey(name: 'currency_symbol') final String currencySymbol,
      @JsonKey(name: 'country_code') final String countryCode,
      @JsonKey(name: 'tax_label') final String taxLabel,
      @JsonKey(name: 'default_tax_rate') final double defaultTaxRate,
      @JsonKey(name: 'date_format') final String dateFormat,
      @JsonKey(name: 'use_lakh_format') final bool useLakhFormat,
      @JsonKey(name: 'invoice_prefix') final String invoicePrefix,
      @JsonKey(name: 'next_invoice_number') final int nextInvoiceNumber,
      @JsonKey(name: 'license_tier') final String licenseTierValue,
      @JsonKey(name: 'tier_expires_at') final DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') final bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') final bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') final int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') final int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override') final int? storageLimitOverride,
      @JsonKey(name: 'operator_note') final String? operatorNote,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt}) = _$BusinessImpl;

  factory _Business.fromJson(Map<String, dynamic> json) =
      _$BusinessImpl.fromJson;

// Core — required
  @override
  String get id;
  @override
  String get name; // Owner
  @override
  @JsonKey(name: 'owner_uid')
  String? get ownerUid; // Contact details — all nullable
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get pincode; // Tax identifiers — nullable
  @override
  String? get gstin;
  @override
  @JsonKey(name: 'tax_number')
  String? get taxNumber; // Branding
  @override
  @JsonKey(name: 'logo_url')
  String?
      get logoUrl; // Currency — database has BOTH 'currency' and 'currency_code'
// Use currency_code as the primary field
  @override
  @JsonKey(name: 'currency_code')
  String
      get currencyCode; // Also map 'currency' column (legacy column in your DB)
  @override
  @JsonKey(name: 'currency')
  String get currency;
  @override
  @JsonKey(name: 'currency_symbol')
  String
      get currencySymbol; // Country code — database has BOTH 'country' and 'country_code'
  @override
  @JsonKey(name: 'country_code')
  String get countryCode; // Tax settings
  @override
  @JsonKey(name: 'tax_label')
  String get taxLabel;
  @override
  @JsonKey(name: 'default_tax_rate')
  double get defaultTaxRate; // Number formatting
  @override
  @JsonKey(name: 'date_format')
  String get dateFormat;
  @override
  @JsonKey(name: 'use_lakh_format')
  bool get useLakhFormat; // Invoice settings
  @override
  @JsonKey(name: 'invoice_prefix')
  String get invoicePrefix;
  @override
  @JsonKey(name: 'next_invoice_number')
  int get nextInvoiceNumber; // License / subscription
  @override
  @JsonKey(name: 'license_tier')
  String get licenseTierValue;
  @override
  @JsonKey(name: 'tier_expires_at')
  DateTime? get tierExpiresAt; // Operator overrides — all nullable
  @override
  @JsonKey(name: 'email_override')
  bool? get emailOverride;
  @override
  @JsonKey(name: 'cron_reminder_override')
  bool? get cronReminderOverride;
  @override
  @JsonKey(name: 'invoice_limit_override')
  int? get invoiceLimitOverride;
  @override
  @JsonKey(name: 'user_limit_override')
  int? get userLimitOverride;
  @override
  @JsonKey(name: 'storage_limit_override')
  int? get storageLimitOverride;
  @override
  @JsonKey(name: 'operator_note')
  String? get operatorNote; // Status
  @override
  @JsonKey(name: 'is_active')
  bool get isActive; // Timestamps
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
