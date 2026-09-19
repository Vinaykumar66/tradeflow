// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerUid: json['owner_uid'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pincode: json['pincode'] as String?,
      gstin: json['gstin'] as String?,
      taxNumber: json['tax_number'] as String?,
      logoUrl: json['logo_url'] as String?,
      currencyCode: json['currency_code'] as String? ?? 'INR',
      currency: json['currency'] as String? ?? 'INR',
      currencySymbol: json['currency_symbol'] as String? ?? 'Rs.',
      countryCode: json['country_code'] as String? ?? 'IN',
      taxLabel: json['tax_label'] as String? ?? 'GST',
      defaultTaxRate: (json['default_tax_rate'] as num?)?.toDouble() ?? 18.0,
      dateFormat: json['date_format'] as String? ?? 'DD/MM/YYYY',
      useLakhFormat: json['use_lakh_format'] as bool? ?? true,
      invoicePrefix: json['invoice_prefix'] as String? ?? 'INV',
      nextInvoiceNumber: (json['next_invoice_number'] as num?)?.toInt() ?? 1,
      licenseTierValue: json['license_tier'] as String? ?? 'starter',
      tierExpiresAt: json['tier_expires_at'] == null
          ? null
          : DateTime.parse(json['tier_expires_at'] as String),
      emailOverride: json['email_override'] as bool?,
      cronReminderOverride: json['cron_reminder_override'] as bool?,
      invoiceLimitOverride: (json['invoice_limit_override'] as num?)?.toInt(),
      userLimitOverride: (json['user_limit_override'] as num?)?.toInt(),
      storageLimitOverride: (json['storage_limit_override'] as num?)?.toInt(),
      operatorNote: json['operator_note'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      defaultPrintFormat:
          json['default_print_format'] as String? ?? kPrintFormatLaser,
      dotMatrixTopMarginLines:
          (json['dot_matrix_top_margin_lines'] as num?)?.toInt() ?? 3,
      dotMatrixLeftMarginChars:
          (json['dot_matrix_left_margin_chars'] as num?)?.toInt() ?? 2,
      einvoiceEnabled: json['einvoice_enabled'] as bool? ?? false,
      ewayBillEnabled: json['eway_bill_enabled'] as bool? ?? false,
      ewayBillThreshold:
          (json['eway_bill_threshold'] as num?)?.toInt() ?? 5000000,
    );

Map<String, dynamic> _$$BusinessImplToJson(_$BusinessImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner_uid': instance.ownerUid,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pincode': instance.pincode,
      'gstin': instance.gstin,
      'tax_number': instance.taxNumber,
      'logo_url': instance.logoUrl,
      'currency_code': instance.currencyCode,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'country_code': instance.countryCode,
      'tax_label': instance.taxLabel,
      'default_tax_rate': instance.defaultTaxRate,
      'date_format': instance.dateFormat,
      'use_lakh_format': instance.useLakhFormat,
      'invoice_prefix': instance.invoicePrefix,
      'next_invoice_number': instance.nextInvoiceNumber,
      'license_tier': instance.licenseTierValue,
      'tier_expires_at': instance.tierExpiresAt?.toIso8601String(),
      'email_override': instance.emailOverride,
      'cron_reminder_override': instance.cronReminderOverride,
      'invoice_limit_override': instance.invoiceLimitOverride,
      'user_limit_override': instance.userLimitOverride,
      'storage_limit_override': instance.storageLimitOverride,
      'operator_note': instance.operatorNote,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'default_print_format': instance.defaultPrintFormat,
      'dot_matrix_top_margin_lines': instance.dotMatrixTopMarginLines,
      'dot_matrix_left_margin_chars': instance.dotMatrixLeftMarginChars,
      'einvoice_enabled': instance.einvoiceEnabled,
      'eway_bill_enabled': instance.ewayBillEnabled,
      'eway_bill_threshold': instance.ewayBillThreshold,
    };
