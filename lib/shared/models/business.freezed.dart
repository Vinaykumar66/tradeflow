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
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_uid')
  String get ownerUid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  String? get gstin => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_url')
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get currency =>
      throw _privateConstructorUsedError; // ── INTERNATIONALISATION ─────────────────────────────────────
  @JsonKey(name: 'currency_symbol')
  String? get currencySymbol => throw _privateConstructorUsedError;
  @JsonKey(name: 'next_invoice_number')
  int? get nextInvoiceNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_prefix')
  String? get invoicePrefix => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'currency_code')
  String get currencyCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_code')
  String get countryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'tax_label')
  String get taxLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_tax_rate')
  double get defaultTaxRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_format')
  String get dateFormat => throw _privateConstructorUsedError;
  @JsonKey(name: 'use_lakh_format')
  bool get useLakhFormat =>
      throw _privateConstructorUsedError; // ── LICENSE ──────────────────────────────────────────────────
  @JsonKey(name: 'license_tier')
  String? get licenseTierValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'tier_expires_at')
  DateTime? get tierExpiresAt =>
      throw _privateConstructorUsedError; //── OPERATOR OVERRIDES ───────────────────────────────────────
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
      @JsonKey(name: 'owner_uid') String ownerUid,
      String email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? country,
      String? pincode,
      String? gstin,
      @JsonKey(name: 'logo_url') String? logoUrl,
      String? currency,
      @JsonKey(name: 'currency_symbol') String? currencySymbol,
      @JsonKey(name: 'next_invoice_number') int? nextInvoiceNumber,
      @JsonKey(name: 'invoice_prefix') String? invoicePrefix,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'country_code') String countryCode,
      @JsonKey(name: 'tax_label') String taxLabel,
      @JsonKey(name: 'default_tax_rate') double defaultTaxRate,
      @JsonKey(name: 'date_format') String dateFormat,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      @JsonKey(name: 'license_tier') String? licenseTierValue,
      @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override') int? storageLimitOverride});
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
    Object? ownerUid = null,
    Object? email = null,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
    Object? gstin = freezed,
    Object? logoUrl = freezed,
    Object? currency = freezed,
    Object? currencySymbol = freezed,
    Object? nextInvoiceNumber = freezed,
    Object? invoicePrefix = freezed,
    Object? createdAt = null,
    Object? currencyCode = null,
    Object? countryCode = null,
    Object? taxLabel = null,
    Object? defaultTaxRate = null,
    Object? dateFormat = null,
    Object? useLakhFormat = null,
    Object? licenseTierValue = freezed,
    Object? tierExpiresAt = freezed,
    Object? emailOverride = freezed,
    Object? cronReminderOverride = freezed,
    Object? invoiceLimitOverride = freezed,
    Object? userLimitOverride = freezed,
    Object? storageLimitOverride = freezed,
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
      ownerUid: null == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      currencySymbol: freezed == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      nextInvoiceNumber: freezed == nextInvoiceNumber
          ? _value.nextInvoiceNumber
          : nextInvoiceNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      invoicePrefix: freezed == invoicePrefix
          ? _value.invoicePrefix
          : invoicePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
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
      licenseTierValue: freezed == licenseTierValue
          ? _value.licenseTierValue
          : licenseTierValue // ignore: cast_nullable_to_non_nullable
              as String?,
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
      @JsonKey(name: 'owner_uid') String ownerUid,
      String email,
      String? phone,
      String? address,
      String? city,
      String? state,
      String? country,
      String? pincode,
      String? gstin,
      @JsonKey(name: 'logo_url') String? logoUrl,
      String? currency,
      @JsonKey(name: 'currency_symbol') String? currencySymbol,
      @JsonKey(name: 'next_invoice_number') int? nextInvoiceNumber,
      @JsonKey(name: 'invoice_prefix') String? invoicePrefix,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'currency_code') String currencyCode,
      @JsonKey(name: 'country_code') String countryCode,
      @JsonKey(name: 'tax_label') String taxLabel,
      @JsonKey(name: 'default_tax_rate') double defaultTaxRate,
      @JsonKey(name: 'date_format') String dateFormat,
      @JsonKey(name: 'use_lakh_format') bool useLakhFormat,
      @JsonKey(name: 'license_tier') String? licenseTierValue,
      @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override') int? storageLimitOverride});
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
    Object? ownerUid = null,
    Object? email = null,
    Object? phone = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? pincode = freezed,
    Object? gstin = freezed,
    Object? logoUrl = freezed,
    Object? currency = freezed,
    Object? currencySymbol = freezed,
    Object? nextInvoiceNumber = freezed,
    Object? invoicePrefix = freezed,
    Object? createdAt = null,
    Object? currencyCode = null,
    Object? countryCode = null,
    Object? taxLabel = null,
    Object? defaultTaxRate = null,
    Object? dateFormat = null,
    Object? useLakhFormat = null,
    Object? licenseTierValue = freezed,
    Object? tierExpiresAt = freezed,
    Object? emailOverride = freezed,
    Object? cronReminderOverride = freezed,
    Object? invoiceLimitOverride = freezed,
    Object? userLimitOverride = freezed,
    Object? storageLimitOverride = freezed,
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
      ownerUid: null == ownerUid
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      currencySymbol: freezed == currencySymbol
          ? _value.currencySymbol
          : currencySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      nextInvoiceNumber: freezed == nextInvoiceNumber
          ? _value.nextInvoiceNumber
          : nextInvoiceNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      invoicePrefix: freezed == invoicePrefix
          ? _value.invoicePrefix
          : invoicePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
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
      licenseTierValue: freezed == licenseTierValue
          ? _value.licenseTierValue
          : licenseTierValue // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessImpl implements _Business {
  const _$BusinessImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'owner_uid') required this.ownerUid,
      required this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.country = 'India',
      this.pincode,
      this.gstin,
      @JsonKey(name: 'logo_url') this.logoUrl,
      this.currency = 'INR',
      @JsonKey(name: 'currency_symbol') this.currencySymbol = '₹.',
      @JsonKey(name: 'next_invoice_number') this.nextInvoiceNumber = 1,
      @JsonKey(name: 'invoice_prefix') this.invoicePrefix = 'INV',
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'currency_code') this.currencyCode = 'INR',
      @JsonKey(name: 'country_code') this.countryCode = 'IN',
      @JsonKey(name: 'tax_label') this.taxLabel = 'GST',
      @JsonKey(name: 'default_tax_rate') this.defaultTaxRate = 18.0,
      @JsonKey(name: 'date_format') this.dateFormat = 'DD/MM/YYYY',
      @JsonKey(name: 'use_lakh_format') this.useLakhFormat = true,
      @JsonKey(name: 'license_tier') this.licenseTierValue = 'starter',
      @JsonKey(name: 'tier_expires_at') this.tierExpiresAt,
      @JsonKey(name: 'email_override') this.emailOverride,
      @JsonKey(name: 'cron_reminder_override') this.cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') this.invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') this.userLimitOverride,
      @JsonKey(name: 'storage_limit_override') this.storageLimitOverride});

  factory _$BusinessImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: 'owner_uid')
  final String ownerUid;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  @JsonKey()
  final String? country;
  @override
  final String? pincode;
  @override
  final String? gstin;
  @override
  @JsonKey(name: 'logo_url')
  final String? logoUrl;
  @override
  @JsonKey()
  final String? currency;
// ── INTERNATIONALISATION ─────────────────────────────────────
  @override
  @JsonKey(name: 'currency_symbol')
  final String? currencySymbol;
  @override
  @JsonKey(name: 'next_invoice_number')
  final int? nextInvoiceNumber;
  @override
  @JsonKey(name: 'invoice_prefix')
  final String? invoicePrefix;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'currency_code')
  final String currencyCode;
  @override
  @JsonKey(name: 'country_code')
  final String countryCode;
  @override
  @JsonKey(name: 'tax_label')
  final String taxLabel;
  @override
  @JsonKey(name: 'default_tax_rate')
  final double defaultTaxRate;
  @override
  @JsonKey(name: 'date_format')
  final String dateFormat;
  @override
  @JsonKey(name: 'use_lakh_format')
  final bool useLakhFormat;
// ── LICENSE ──────────────────────────────────────────────────
  @override
  @JsonKey(name: 'license_tier')
  final String? licenseTierValue;
  @override
  @JsonKey(name: 'tier_expires_at')
  final DateTime? tierExpiresAt;
//── OPERATOR OVERRIDES ───────────────────────────────────────
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
  String toString() {
    return 'Business(id: $id, name: $name, ownerUid: $ownerUid, email: $email, phone: $phone, address: $address, city: $city, state: $state, country: $country, pincode: $pincode, gstin: $gstin, logoUrl: $logoUrl, currency: $currency, currencySymbol: $currencySymbol, nextInvoiceNumber: $nextInvoiceNumber, invoicePrefix: $invoicePrefix, createdAt: $createdAt, currencyCode: $currencyCode, countryCode: $countryCode, taxLabel: $taxLabel, defaultTaxRate: $defaultTaxRate, dateFormat: $dateFormat, useLakhFormat: $useLakhFormat, licenseTierValue: $licenseTierValue, tierExpiresAt: $tierExpiresAt, emailOverride: $emailOverride, cronReminderOverride: $cronReminderOverride, invoiceLimitOverride: $invoiceLimitOverride, userLimitOverride: $userLimitOverride, storageLimitOverride: $storageLimitOverride)';
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
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.currencySymbol, currencySymbol) ||
                other.currencySymbol == currencySymbol) &&
            (identical(other.nextInvoiceNumber, nextInvoiceNumber) ||
                other.nextInvoiceNumber == nextInvoiceNumber) &&
            (identical(other.invoicePrefix, invoicePrefix) ||
                other.invoicePrefix == invoicePrefix) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
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
                other.storageLimitOverride == storageLimitOverride));
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
        logoUrl,
        currency,
        currencySymbol,
        nextInvoiceNumber,
        invoicePrefix,
        createdAt,
        currencyCode,
        countryCode,
        taxLabel,
        defaultTaxRate,
        dateFormat,
        useLakhFormat,
        licenseTierValue,
        tierExpiresAt,
        emailOverride,
        cronReminderOverride,
        invoiceLimitOverride,
        userLimitOverride,
        storageLimitOverride
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
      @JsonKey(name: 'owner_uid') required final String ownerUid,
      required final String email,
      final String? phone,
      final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? pincode,
      final String? gstin,
      @JsonKey(name: 'logo_url') final String? logoUrl,
      final String? currency,
      @JsonKey(name: 'currency_symbol') final String? currencySymbol,
      @JsonKey(name: 'next_invoice_number') final int? nextInvoiceNumber,
      @JsonKey(name: 'invoice_prefix') final String? invoicePrefix,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'currency_code') final String currencyCode,
      @JsonKey(name: 'country_code') final String countryCode,
      @JsonKey(name: 'tax_label') final String taxLabel,
      @JsonKey(name: 'default_tax_rate') final double defaultTaxRate,
      @JsonKey(name: 'date_format') final String dateFormat,
      @JsonKey(name: 'use_lakh_format') final bool useLakhFormat,
      @JsonKey(name: 'license_tier') final String? licenseTierValue,
      @JsonKey(name: 'tier_expires_at') final DateTime? tierExpiresAt,
      @JsonKey(name: 'email_override') final bool? emailOverride,
      @JsonKey(name: 'cron_reminder_override') final bool? cronReminderOverride,
      @JsonKey(name: 'invoice_limit_override') final int? invoiceLimitOverride,
      @JsonKey(name: 'user_limit_override') final int? userLimitOverride,
      @JsonKey(name: 'storage_limit_override')
      final int? storageLimitOverride}) = _$BusinessImpl;

  factory _Business.fromJson(Map<String, dynamic> json) =
      _$BusinessImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'owner_uid')
  String get ownerUid;
  @override
  String get email;
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
  String? get pincode;
  @override
  String? get gstin;
  @override
  @JsonKey(name: 'logo_url')
  String? get logoUrl;
  @override
  String?
      get currency; // ── INTERNATIONALISATION ─────────────────────────────────────
  @override
  @JsonKey(name: 'currency_symbol')
  String? get currencySymbol;
  @override
  @JsonKey(name: 'next_invoice_number')
  int? get nextInvoiceNumber;
  @override
  @JsonKey(name: 'invoice_prefix')
  String? get invoicePrefix;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'currency_code')
  String get currencyCode;
  @override
  @JsonKey(name: 'country_code')
  String get countryCode;
  @override
  @JsonKey(name: 'tax_label')
  String get taxLabel;
  @override
  @JsonKey(name: 'default_tax_rate')
  double get defaultTaxRate;
  @override
  @JsonKey(name: 'date_format')
  String get dateFormat;
  @override
  @JsonKey(name: 'use_lakh_format')
  bool
      get useLakhFormat; // ── LICENSE ──────────────────────────────────────────────────
  @override
  @JsonKey(name: 'license_tier')
  String? get licenseTierValue;
  @override
  @JsonKey(name: 'tier_expires_at')
  DateTime?
      get tierExpiresAt; //── OPERATOR OVERRIDES ───────────────────────────────────────
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

  /// Create a copy of Business
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessImplCopyWith<_$BusinessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
