import 'package:freezed_annotation/freezed_annotation.dart';
part 'vendor_payment.freezed.dart';
part 'vendor_payment.g.dart';

@freezed
abstract class VendorPayment with _$VendorPayment {
  const factory VendorPayment({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'vendor_id') required String vendorId,
    @JsonKey(name: 'purchase_bill_id') String? purchaseBillId,
    required int amount,
    @Default('cash') String method,
    String? reference,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
  }) = _VendorPayment;

  factory VendorPayment.fromJson(Map<String, dynamic> json) =>
      _$VendorPaymentFromJson(json);
}
