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
  factory PurchaseBillItem.fromJson(Map<String, dynamic> json) =>
      _$PurchaseBillItemFromJson(json);
}

@freezed
abstract class PurchaseBill with _$PurchaseBill {
  const factory PurchaseBill({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'vendor_id') String? vendorId,
    @JsonKey(name: 'bill_number') required String billNumber,
    @JsonKey(name: 'bill_date') required DateTime billDate,
    @Default(0) int subtotal,
    @JsonKey(name: 'cgst_total') @Default(0) int cgstTotal,
    @JsonKey(name: 'sgst_total') @Default(0) int sgstTotal,
    @JsonKey(name: 'igst_total') @Default(0) int igstTotal,
    @JsonKey(name: 'ugst_total') @Default(0) int ugstTotal,
    @Default(0) int total,
    @Default('received') String status,
    String? notes,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<PurchaseBillItem> items,
  }) = _PurchaseBill;

  factory PurchaseBill.fromJson(Map<String, dynamic> json) =>
      _$PurchaseBillFromJson(json);
}

extension PurchaseBillItemX on PurchaseBillItem {
  PurchaseBillItem recalculate({String? sellerState, String? buyState}) {
    final gross = (unitPrice * quantity).round();
    final tax = (gross * taxRate / 100).round();
    final total = gross + tax;

    final split = GstSplitCalculator.split(
        sellerState: sellerState, buyerState: buyerState, totalTaxPaise: tax);

    return copyWith(
        lineTotal: total,
        cgstAmount: split.cgst,
        sgstAmount: split.sgst,
        igstAmount: split.igst,
        ugstAmount: split.ugst);
  }

  Map<String, dynamic> toInsertMap(String billId, String bizId) => {
        'purchase_bill_id': billId,
        'business_id': bizId,
        'product_id': productId,
        'name': name,
        'quantity': quantity,
        'unit_price': unitPrice,
        'tax_rate': taxRate,
        'cgst_amount': cgstAmount,
        'sgst_amount': sgstAmount,
        'igst_amount': igstAmount,
        'ugst_amount': ugstAmount,
        'line_total': lineTotal,
      };
}
