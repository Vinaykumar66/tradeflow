import 'package:freezed_annotation/freezed_annotation.dart';
part 'eway_bill.freezed.dart';
part 'eway_bill.g.dart';

@freezed
abstract class EwayBill with _$EwayBill {
  const factory EwayBill({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'invoice_id') required String invoiceId,
    String? ebn,
    @JsonKey(name: 'transporter_name') String? transporterName,
    @JsonKey(name: 'transporter_gstin') String? transporterGstin,
    @JsonKey(name: 'vehicle_number') String? vehicleNumber,
    @JsonKey(name: 'transport_mode') @Default('road') String transportMode,
    @JsonKey(name: 'distance_km') int? distanceKm,
    @JsonKey(name: 'valid_until') DateTime? validUntil,
    @Default('not_generated') String status,
  }) = _EwayBill;

  factory EwayBill.fromJson(Map<String, dynamic> json) =>
      _$EwayBillFromJson(json);
}
