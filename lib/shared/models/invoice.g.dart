// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      customerId: json['customer_id'] as String?,
      invoiceNumber: json['invoice_number'] as String,
      documentType: json['document_type'] as String? ?? kDocTypeInvoice,
      status: json['status'] as String? ?? 'draft',
      issueDate: DateTime.parse(json['issue_date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      subtotal: (json['subtotal'] as num?)?.toInt() ?? 0,
      discountAmount: (json['discount_amount'] as num?)?.toInt() ?? 0,
      taxAmount: (json['tax_amount'] as num?)?.toInt() ?? 0,
      cgstTotal: (json['cgst_total'] as num?)?.toInt() ?? 0,
      sgstTotal: (json['sgst_total'] as num?)?.toInt() ?? 0,
      igstTotal: (json['igst_total'] as num?)?.toInt() ?? 0,
      ugstTotal: (json['ugst_total'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      amountPaid: (json['amount_paid'] as num?)?.toInt() ?? 0,
      currencyCode: json['currency_code'] as String? ?? 'INR',
      currencySymbol: json['currency_symbol'] as String? ?? 'Rs.',
      useLakhFormat: json['use_lakh_format'] as bool? ?? true,
      notes: json['notes'] as String?,
      terms: json['terms'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      convertedToInvoiceId: json['converted_to_invoice_id'] as String?,
      customerName: json['customer_name'] as String?,
      placeOfSupply: json['place_of_supply'] as String?,
      einvoiceStatus: json['einvoice_status'] as String? ?? 'not_generated',
      irn: json['irn'] as String?,
      ackNumber: json['ack_number'] as String?,
      ackDate: json['ack_date'] == null
          ? null
          : DateTime.parse(json['ack_date'] as String),
      signedQrCode: json['signed_qr_code'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'customer_id': instance.customerId,
      'invoice_number': instance.invoiceNumber,
      'document_type': instance.documentType,
      'status': instance.status,
      'issue_date': instance.issueDate.toIso8601String(),
      'due_date': instance.dueDate?.toIso8601String(),
      'subtotal': instance.subtotal,
      'discount_amount': instance.discountAmount,
      'tax_amount': instance.taxAmount,
      'cgst_total': instance.cgstTotal,
      'sgst_total': instance.sgstTotal,
      'igst_total': instance.igstTotal,
      'ugst_total': instance.ugstTotal,
      'total': instance.total,
      'amount_paid': instance.amountPaid,
      'currency_code': instance.currencyCode,
      'currency_symbol': instance.currencySymbol,
      'use_lakh_format': instance.useLakhFormat,
      'notes': instance.notes,
      'terms': instance.terms,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'converted_to_invoice_id': instance.convertedToInvoiceId,
      'customer_name': instance.customerName,
      'place_of_supply': instance.placeOfSupply,
      'einvoice_status': instance.einvoiceStatus,
      'irn': instance.irn,
      'ack_number': instance.ackNumber,
      'ack_date': instance.ackDate?.toIso8601String(),
      'signed_qr_code': instance.signedQrCode,
      'items': instance.items,
    };

_$InvoiceItemImpl _$$InvoiceItemImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceItemImpl(
      id: json['id'] as String,
      invoiceId: json['invoice_id'] as String,
      businessId: json['business_id'] as String,
      productId: json['product_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      unit: json['unit'] as String? ?? 'pcs',
      unitPrice: (json['unit_price'] as num?)?.toInt() ?? 0,
      discountPct: (json['discount_pct'] as num?)?.toDouble() ?? 0.0,
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 0.0,
      taxInclusive: json['tax_inclusive'] as bool? ?? false,
      taxAmount: (json['tax_amount'] as num?)?.toInt() ?? 0,
      lineTotal: (json['line_total'] as num?)?.toInt() ?? 0,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      cgstAmount: (json['cgst_amount'] as num?)?.toInt() ?? 0,
      sgstAmount: (json['sgst_amount'] as num?)?.toInt() ?? 0,
      igstAmount: (json['igst_amount'] as num?)?.toInt() ?? 0,
      ugstAmount: (json['ugst_amount'] as num?)?.toInt() ?? 0,
      cgstTotal: (json['cgst_total'] as num?)?.toInt() ?? 0,
      sgstTotal: (json['sgst_total'] as num?)?.toInt() ?? 0,
      igstTotal: (json['igst_total'] as num?)?.toInt() ?? 0,
      ugstTotal: (json['ugst_total'] as num?)?.toInt() ?? 0,
      hsnSacCode: json['hsn_sac_code'] as String?,
      commodityCode: json['commodity_code'] as String?,
    );

Map<String, dynamic> _$$InvoiceItemImplToJson(_$InvoiceItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'business_id': instance.businessId,
      'product_id': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'unit_price': instance.unitPrice,
      'discount_pct': instance.discountPct,
      'tax_rate': instance.taxRate,
      'tax_inclusive': instance.taxInclusive,
      'tax_amount': instance.taxAmount,
      'line_total': instance.lineTotal,
      'sort_order': instance.sortOrder,
      'cgst_amount': instance.cgstAmount,
      'sgst_amount': instance.sgstAmount,
      'igst_amount': instance.igstAmount,
      'ugst_amount': instance.ugstAmount,
      'cgst_total': instance.cgstTotal,
      'sgst_total': instance.sgstTotal,
      'igst_total': instance.igstTotal,
      'ugst_total': instance.ugstTotal,
      'hsn_sac_code': instance.hsnSacCode,
      'commodity_code': instance.commodityCode,
    };
