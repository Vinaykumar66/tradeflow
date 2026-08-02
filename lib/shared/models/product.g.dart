// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      businessId: json['business_id'] as String,
      sku: json['sku'] as String,
      category: json['category'] as String?,
      barcode: json['barcode'] as String?,
      brand: json['brand'] as String?,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String?,
      unit: json['unit'] as String?,
      costPrice: (json['cost_price'] as num?)?.toInt() ?? 0,
      sellingPrice: (json['selling_price'] as num?)?.toInt() ?? 0,
      mrp: (json['mrp'] as num?)?.toInt() ?? 0,
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 18.0,
      TaxType: json['tax_type'] as String? ?? 'GST',
      taxInclusive: json['tax_inclusive'] as bool? ?? false,
      stockQty: (json['stock_qty'] as num?)?.toInt() ?? 0,
      reorderLevel: (json['reorder_level'] as num?)?.toInt() ?? 0,
      reorderQty: (json['reorder_qty'] as num?)?.toInt() ?? 0,
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      isActive: json['is_active'] as bool? ?? true,
      trackInventory: json['track_inventory'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdBy: json['created_by'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'business_id': instance.businessId,
      'sku': instance.sku,
      'category': instance.category,
      'barcode': instance.barcode,
      'brand': instance.brand,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'unit': instance.unit,
      'cost_price': instance.costPrice,
      'selling_price': instance.sellingPrice,
      'mrp': instance.mrp,
      'tax_rate': instance.taxRate,
      'tax_type': instance.TaxType,
      'tax_inclusive': instance.taxInclusive,
      'stock_qty': instance.stockQty,
      'reorder_level': instance.reorderLevel,
      'reorder_qty': instance.reorderQty,
      'expiry_date': instance.expiryDate?.toIso8601String(),
      'is_active': instance.isActive,
      'track_inventory': instance.trackInventory,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_by': instance.createdBy,
    };
