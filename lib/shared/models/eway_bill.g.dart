// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eway_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EwayBillImpl _$$EwayBillImplFromJson(Map<String, dynamic> json) =>
    _$EwayBillImpl(
      id: json['id'] as String,
      businessId: json['business_id'] as String,
      invoiceId: json['invoice_id'] as String,
      ebn: json['ebn'] as String?,
      transporterName: json['transporter_name'] as String?,
      transporterGstin: json['transporter_gstin'] as String?,
      vehicleNumber: json['vehicle_number'] as String?,
      transportMode: json['transport_mode'] as String? ?? 'road',
      distanceKm: (json['distance_km'] as num?)?.toInt(),
      validUntil: json['valid_until'] == null
          ? null
          : DateTime.parse(json['valid_until'] as String),
      status: json['status'] as String? ?? 'not_generated',
    );

Map<String, dynamic> _$$EwayBillImplToJson(_$EwayBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'business_id': instance.businessId,
      'invoice_id': instance.invoiceId,
      'ebn': instance.ebn,
      'transporter_name': instance.transporterName,
      'transporter_gstin': instance.transporterGstin,
      'vehicle_number': instance.vehicleNumber,
      'transport_mode': instance.transportMode,
      'distance_km': instance.distanceKm,
      'valid_until': instance.validUntil?.toIso8601String(),
      'status': instance.status,
    };
