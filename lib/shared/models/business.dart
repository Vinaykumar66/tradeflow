import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tradeflow/shared/models/license_tier.dart';
import '../../../core/interfaces/i_invoice_printer.dart';
import '../../features/invoices/data/printers/dot_matrix_invoice_printer.dart';
part 'business.freezed.dart';
part 'business.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    // Core — required
    required String id,
    required String name,

    // Owner
    @JsonKey(name: 'owner_uid') String? ownerUid,

    // Contact details — all nullable
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? pincode,

    // Tax identifiers — nullable
    String? gstin,
    @JsonKey(name: 'tax_number') String? taxNumber,

    // Branding
    @JsonKey(name: 'logo_url') String? logoUrl,

    // Currency — database has BOTH 'currency' and 'currency_code'
    // Use currency_code as the primary field
    @JsonKey(name: 'currency_code') @Default('INR') String currencyCode,

    // Also map 'currency' column (legacy column in your DB)
    @JsonKey(name: 'currency') @Default('INR') String currency,
    @JsonKey(name: 'currency_symbol') @Default('Rs.') String currencySymbol,

    // Country code — database has BOTH 'country' and 'country_code'
    @JsonKey(name: 'country_code') @Default('IN') String countryCode,

    // Tax settings
    @JsonKey(name: 'tax_label') @Default('GST') String taxLabel,
    @JsonKey(name: 'default_tax_rate') @Default(18.0) double defaultTaxRate,

    // Number formatting
    @JsonKey(name: 'date_format') @Default('DD/MM/YYYY') String dateFormat,
    @JsonKey(name: 'use_lakh_format') @Default(true) bool useLakhFormat,

    // Invoice settings
    @JsonKey(name: 'invoice_prefix') @Default('INV') String invoicePrefix,
    @JsonKey(name: 'next_invoice_number') @Default(1) int nextInvoiceNumber,

    // License / subscription
    @JsonKey(name: 'license_tier') @Default('starter') String licenseTierValue,
    @JsonKey(name: 'tier_expires_at') DateTime? tierExpiresAt,

    // Operator overrides — all nullable
    @JsonKey(name: 'email_override') bool? emailOverride,
    @JsonKey(name: 'cron_reminder_override') bool? cronReminderOverride,
    @JsonKey(name: 'invoice_limit_override') int? invoiceLimitOverride,
    @JsonKey(name: 'user_limit_override') int? userLimitOverride,
    @JsonKey(name: 'storage_limit_override') int? storageLimitOverride,
    @JsonKey(name: 'operator_note') String? operatorNote,

    // Status
    @JsonKey(name: 'is_active') @Default(true) bool isActive,

    // Timestamps
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'default_print_format')
    @Default(kPrintFormatLaser)
    String defaultPrintFormat,
    @JsonKey(name: 'dot_matrix_top_margin_lines')
    @Default(3)
    int dotMatrixTopMarginLines,
    @JsonKey(name: 'dot_matrix_left_margin_chars')
    @Default(2)
    int dotMatrixLeftMarginChars,
    @JsonKey(name: 'einvoice_enabled') @Default(false) bool einvoiceEnabled,
    @JsonKey(name: 'eway_bill_enabled') @Default(false) bool ewayBillEnabled,
    @JsonKey(name: 'eway_bill_threshold')
    @Default(5000000)
    int ewayBillThreshold,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}

// Extension for computed properties
extension BusinessX on Business {
  // Effective currency symbol for display
  String? get displayCurrencySymbol => currencySymbol;

  // License tier as enum
  LicenseTier get licenseTier => LicenseTierX.fromString(licenseTierValue!);

  // Check if tier is expired
  bool get isTierExpired =>
      tierExpiresAt != null && tierExpiresAt!.isBefore(DateTime.now());

  // Effective tier considering expiry
  LicenseTier get effectiveTier =>
      isTierExpired ? LicenseTier.starter : licenseTier;

  static Business fromMap(Map<String, dynamic> m) => Business.fromJson(m);

  Map<String, dynamic> toUpdateMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'pincode': pincode,
        'gstin': gstin,
        'tax_number': taxNumber,
        'logo_url': logoUrl,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'country_code': countryCode,
        'tax_label': taxLabel,
        'default_tax_rate': defaultTaxRate,
        'date_format': dateFormat,
        'use_lakh_format': useLakhFormat,
        'invoice_prefix': invoicePrefix,
        'license_tier': licenseTierValue,
        'updated_at': DateTime.now().toIso8601String(),
        'default_print_format': defaultPrintFormat,
        'dot_matrix_top_margin_lines': dotMatrixTopMarginLines,
        'dot_matrix_left_margin_chars': dotMatrixLeftMarginChars,
        'einvoice_enabled': einvoiceEnabled,
        'eway_bill_enabled': ewayBillEnabled,
        'eway_bill_threshold': ewayBillThreshold,
      };
}
