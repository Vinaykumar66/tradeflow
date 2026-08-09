// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      gstin: json['gstin'] as String?,
      creditLimit: (json['credit_limit'] as num?)?.toInt() ?? 0,
      outstanding: (json['outstanding'] as num?)?.toInt() ?? 0,
      paymentTerms: (json['payment_terms'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'gstin': instance.gstin,
      'credit_limit': instance.creditLimit,
      'outstanding': instance.outstanding,
      'payment_terms': instance.paymentTerms,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
    };
