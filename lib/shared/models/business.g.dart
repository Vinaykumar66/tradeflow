// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessImpl _$$BusinessImplFromJson(Map<String, dynamic> json) =>
    _$BusinessImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerUid: json['owner_uid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String? ?? 'India',
      pincode: json['pincode'] as String?,
      gstin: json['gstin'] as String?,
      logoUrl: json['logo_url'] as String?,
      currency: json['currency'] as String? ?? 'INR',
      currencySymbol: json['currency_symbol'] as String? ?? '₹.',
      nextInvoiceNumber: (json['next_invoice_number'] as num?)?.toInt() ?? 1,
      invoicePrefix: json['invoice_prefix'] as String? ?? 'INV',
      createdAt: DateTime.parse(json['created_at'] as String),
      currencyCode: json['currency_code'] as String? ?? 'INR',
      countryCode: json['country_code'] as String? ?? 'IN',
      taxLabel: json['tax_label'] as String? ?? 'GST',
      defaultTaxRate: (json['default_tax_rate'] as num?)?.toDouble() ?? 18.0,
      dateFormat: json['date_format'] as String? ?? 'DD/MM/YYYY',
      useLakhFormat: json['use_lakh_format'] as bool? ?? true,
      licenseTierValue: json['license_tier'] as String? ?? 'starter',
      tierExpiresAt: json['tier_expires_at'] == null
          ? null
          : DateTime.parse(json['tier_expires_at'] as String),
      emailOverride: json['email_override'] as bool?,
      cronReminderOverride: json['cron_reminder_override'] as bool?,
      invoiceLimitOverride: (json['invoice_limit_override'] as num?)?.toInt(),
      userLimitOverride: (json['user_limit_override'] as num?)?.toInt(),
      storageLimitOverride: (json['storage_limit_override'] as num?)?.toInt(),
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
      'logo_url': instance.logoUrl,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'next_invoice_number': instance.nextInvoiceNumber,
      'invoice_prefix': instance.invoicePrefix,
      'created_at': instance.createdAt.toIso8601String(),
      'currency_code': instance.currencyCode,
      'country_code': instance.countryCode,
      'tax_label': instance.taxLabel,
      'default_tax_rate': instance.defaultTaxRate,
      'date_format': instance.dateFormat,
      'use_lakh_format': instance.useLakhFormat,
      'license_tier': instance.licenseTierValue,
      'tier_expires_at': instance.tierExpiresAt?.toIso8601String(),
      'email_override': instance.emailOverride,
      'cron_reminder_override': instance.cronReminderOverride,
      'invoice_limit_override': instance.invoiceLimitOverride,
      'user_limit_override': instance.userLimitOverride,
      'storage_limit_override': instance.storageLimitOverride,
    };
