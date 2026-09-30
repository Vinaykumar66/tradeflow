// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VendorPaymentImpl _$$VendorPaymentImplFromJson(Map<String, dynamic> json) =>
    _$VendorPaymentImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      vendorId: json['vendor_id'] as String,
      purchaseBillId: json['purchase_bill_id'] as String?,
      amount: (json['amount'] as num).toInt(),
      method: json['method'] as String? ?? 'cash',
      reference: json['reference'] as String?,
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
    );

Map<String, dynamic> _$$VendorPaymentImplToJson(_$VendorPaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'vendor_id': instance.vendorId,
      'purchase_bill_id': instance.purchaseBillId,
      'amount': instance.amount,
      'method': instance.method,
      'reference': instance.reference,
      'paid_at': instance.paidAt?.toIso8601String(),
    };
