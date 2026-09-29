// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseBillItemImpl _$$PurchaseBillItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseBillItemImpl(
      id: json['id'] as String,
      purchaseBillId: json['purchase_bill_id'] as String,
      businessId: json['business_id'] as String,
      productId: json['product_id'] as String?,
      name: json['name'] as String,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      unitPrice: (json['unit_price'] as num?)?.toInt() ?? 0,
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 0.0,
      cgstAmount: (json['cgst_amount'] as num?)?.toInt() ?? 0,
      sgstAmount: (json['sgst_amount'] as num?)?.toInt() ?? 0,
      igstAmount: (json['igst_amount'] as num?)?.toInt() ?? 0,
      ugstAmount: (json['ugst_amount'] as num?)?.toInt() ?? 0,
      lineTotal: (json['line_total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PurchaseBillItemImplToJson(
        _$PurchaseBillItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchase_bill_id': instance.purchaseBillId,
      'business_id': instance.businessId,
      'product_id': instance.productId,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'tax_rate': instance.taxRate,
      'cgst_amount': instance.cgstAmount,
      'sgst_amount': instance.sgstAmount,
      'igst_amount': instance.igstAmount,
      'ugst_amount': instance.ugstAmount,
      'line_total': instance.lineTotal,
    };

_$PurchaseBillImpl _$$PurchaseBillImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseBillImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      vendorId: json['vendor_id'] as String?,
      billNumber: json['bill_number'] as String,
      billDate: DateTime.parse(json['bill_date'] as String),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      cgstTotal: (json['cgst_total'] as num?)?.toInt() ?? 0,
      sgstTotal: (json['sgst_total'] as num?)?.toInt() ?? 0,
      igstTotal: (json['igst_total'] as num?)?.toInt() ?? 0,
      ugstTotal: (json['ugst_total'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'received',
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PurchaseBillImplToJson(_$PurchaseBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'vendor_id': instance.vendorId,
      'bill_number': instance.billNumber,
      'bill_date': instance.billDate.toIso8601String(),
      'subtotal': instance.subtotal,
      'cgst_total': instance.cgstTotal,
      'sgst_total': instance.sgstTotal,
      'igst_total': instance.igstTotal,
      'ugst_total': instance.ugstTotal,
      'total': instance.total,
      'status': instance.status,
      'notes': instance.notes,
    };
