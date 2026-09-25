import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/utils/gst_split_calculator.dart';
part 'purchase_bill.freezed.dart';
part 'purchase_bill.g.dart';

@freezed
abstract class PurchaseBillItem with _$PurchaseBillItem {
  const factory PurchaseBillItem({
    required String id,
    @JsonKey(name: 'purchase_bill_id') required String purchaseBillId,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'product_id') String? productId,
    required String name,
    @Default(1.0) double quantity,
    @JsonKey(name: 'unit_price') @Default(0) int unitPrice,
    @JsonKey(name: 'tax_rate') @Default(0.0) double taxRate,
    @JsonKey(name: 'cgst_amount') @Default(0) int cgstAmount,
    @JsonKey(name: 'sgst_amount') @Default(0) int sgstAmount,
    @JsonKey(name: 'igst_amount') @Default(0) int igstAmount,
    @JsonKey(name: 'ugst_amount') @Default(0) int ugstAmount,
    @JsonKey(name: 'line_total') @Default(0) int lineTotal,
  }) = _PurchaseBillItem;
  factory PurchaseBillItem.fromJson(Map<String, dynamic>json) => _$PurchaseBillItemFromJson(json);
}

@freezed
abstract class PurchaseBill with _$PurchaseBill {
  
} 