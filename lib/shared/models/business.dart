import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'license_tier.dart';

part 'business.freezed.dart';
part 'business.g.dart';

@freezed
abstract class Business with _$Business {
  const factory Business({
    required String id,
    required String name,
    @JsonKey(name: 'owner_uid') required String ownerUid,
    required String email,
    String? phone,
    String? address,
    String? city,
    String? state,
    @Default('India') String? country,
    String? pincode,
    String? gstin,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @Default('INR') String? currency,
    // ── INTERNATIONALISATION ─────────────────────────────────────
    @JsonKey(name: 'currency_symbol') @Default('₹.') String? currencySymbol,
    @JsonKey(name: 'next_invoice_number') @Default(1) int? nextInvoiceNumber,
    @JsonKey(name: 'invoice_prefix') @Default('INV') String? invoicePrefix,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'currency_code') @Default('INR') String currencyCode,
    @JsonKey(name: 'country_code') @Default('IN') String countryCode,
    @JsonKey(name: 'tax_label') @Default('GST') String taxLabel,
    @JsonKey(name: 'default_tax_rate') @Default(18.0) double defaultTaxRate,
    @JsonKey(name: 'date_format') @Default('DD/MM/YYYY') String dateFormat,
    @JsonKey(name: 'use_lakh_format') @Default(true) bool useLakhFormat,
    // ── LICENSE ──────────────────────────────────────────────────
    @JsonKey(name: 'license_tier') @Default('starter') String? licenseTierValue,
    @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,
    //── OPERATOR OVERRIDES ───────────────────────────────────────
    @JsonKey(name: 'email_override') bool? emailOverride,
    @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
    @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
    @JsonKey(name: 'user_limit_override') int? userLimitOverride,
    @JsonKey(name: 'storage_limit_override') int? storageLimitOverride,
  }) = _Business;
  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}

extension BusinessX on Business {
  LicenseTier get licenseTier => LicenseTierX.fromString(licenseTierValue!);
  static Business fromMap(Map<String, dynamic> m) => Business.fromJson(m);
  Map<String, dynamic> toInsertMap() => {
        'name': name,
        'owner_uid': ownerUid,
        'email': email,
        'phone': phone,
        'gstin': gstin,
        'currency': currency,
        'currency_symbol': currencySymbol,
        'license_tier': licenseTierValue
      };
  Map<String, dynamic> toUpdateMap() => {
        'name': name,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'pincode': pincode,
        'gstin': gstin,
        'logo_url': logoUrl
      };
  String get formattedNextInvoiceNumber =>
      '$invoicePrefix-${nextInvoiceNumber.toString().padLeft(4, '0')}';
  // Effective invoice limit: override beats tier default
  int get effectiveInvoiceLimit =>
      invoiceLimitOverride ?? licenseTier.monthlyInvoiceLimit;

// Effective user limit: override beats tier default
  int get effectiveUserLimit => userLimitOverride ?? licenseTier.maxUsers;

// Effective storage limit: override beats tier default
  int get effectiveStorageLimit =>
      storageLimitOverride ?? licenseTier.storageLimitBytes;

// Email allowed: operator override takes precedence over tier
  bool get effectiveEmailAllowed => emailOverride ?? licenseTier.emailAllowed;

// Cron reminders: operator override takes precedence over tier
  bool get effectiveCronRemindersAllowed =>
      cronReminderOverride ?? licenseTier.cronRemindersAllowed;
}
