// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaxCodeImpl _$$TaxCodeImplFromJson(Map<String, dynamic> json) =>
    _$TaxCodeImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      name: json['name'] as String,
      rate: (json['rate'] as num).toDouble(),
      isInclusive: json['is_inclusive'] as bool? ?? false,
      isDefault: json['is_default'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$TaxCodeImplToJson(_$TaxCodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'name': instance.name,
      'rate': instance.rate,
      'is_inclusive': instance.isInclusive,
      'is_default': instance.isDefault,
      'is_active': instance.isActive,
    };
