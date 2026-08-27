import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tradeflow/core/utils/currency_formatter.dart';
import '../../core/utils/gst_split_calculator.dart';
part 'invoice.freezed.dart';
part 'invoice.g.dart';

//Invoice status values

const kStatusDraft = 'draft';
const kStatusSent = 'sent';
const kStatusPaid = 'paid';
const kStatusPartial = 'partial';
const kStatusCancelled = 'cancelled';
const kDocTypeInvoice = 'invoice';
const kDocTypeProforma = 'proforma';
const kDocTypeEstimate = 'estimate';
const kDocTypeQuotation = 'quotation';

@freezed
abstract class Invoice with _$Invoice {
  const factory Invoice({
    required String id,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'customer_id') String? customerId,
    @JsonKey(name: 'invoice_number') required String invoiceNumber,
    @JsonKey(name: 'document_type')
    @Default(kDocTypeInvoice)
    String documentType,
    @Default('draft') String status,
    @JsonKey(name: 'issue_date') required DateTime issueDate,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    // Amounts in smallest currency unit
    @JsonKey(name: 'subtotal') @Default(0) int subtotal,
    @JsonKey(name: 'discount_amount') @Default(0) int discountAmount,
    @JsonKey(name: 'tax_amount') @Default(0) int taxAmount,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'amount_paid') @Default(0) int amountPaid,
    // Currency snapshot at time of invoice creation
    @JsonKey(name: 'currency_code') @Default('INR') String currencyCode,
    @JsonKey(name: 'currency_symbol') @Default('Rs.') String currencySymbol,
    @JsonKey(name: 'use_lakh_format') @Default(true) bool useLakhFormat,
    String? notes,
    String? terms,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    // Populated by join — not stored in invoices table
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default([])
    List<InvoiceItem> items,
  }) = _Invoice;
  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
}

@freezed
abstract class InvoiceItem with _$InvoiceItem {
  const factory InvoiceItem({
    required String id,
    @JsonKey(name: 'invoice_id') required String invoiceId,
    @JsonKey(name: 'business_id') required String businessId,
    @JsonKey(name: 'product_id') String? productId,
    required String name,
    String? description,
    @Default(1.0) double quantity,
    @Default('pcs') String unit,
    @JsonKey(name: 'unit_price') @Default(0) int unitPrice,
    @JsonKey(name: 'discount_pct') @Default(0.0) double discountPct,
    @JsonKey(name: 'tax_rate') @Default(0.0) double taxRate,
    @JsonKey(name: 'tax_inclusive') @Default(false) bool taxInclusive,
    @JsonKey(name: 'tax_amount') @Default(0) int taxAmount,
    @JsonKey(name: 'line_total') @Default(0) int lineTotal,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
//GST calc, tax amount
    @JsonKey(name: 'cgst_amount') @Default(0) int cgstAmount,
    @JsonKey(name: 'sgst_amount') @Default(0) int sgstAmount,
    @JsonKey(name: 'igst_amount') @Default(0) int igstAmount,
    @JsonKey(name: 'ugst_amount') @Default(0) int ugstAmount,

//GST calc tax total
    @JsonKey(name: 'cgst_total') @Default(0) int cgstTotal,
    @JsonKey(name: 'sgst_total') @Default(0) int sgstTotal,
    @JsonKey(name: 'igst_total') @Default(0) int igstTotal,
    @JsonKey(name: 'ugst_total') @Default(0) int ugstTotal,
  }) = _InvoiceItem;
  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
}

extension InvoiceX on Invoice {
  static Invoice fromMap(Map<String, dynamic> m) => Invoice.fromJson(m);
  int get balanceDue => total - amountPaid;
  bool get isOverdue =>
      dueDate != null &&
      dueDate!.isBefore(DateTime.now()) &&
      status != kStatusPaid &&
      status != kStatusCancelled;
  String fmt(int amount) => CurrencyFormatter.format(amount,
      sym: currencySymbol, lakh: useLakhFormat);
  String get formattedTotal => fmt(total);
  String get formattedBalanceDue => fmt(balanceDue);
  String get formattedAmountPaid => fmt(amountPaid);
  String get formattedSubtotal => fmt(subtotal);
  String get formattedTax => fmt(taxAmount);
  String get formattedDiscount => fmt(discountAmount);
}

extension InvoiceItemX on InvoiceItem {
  static InvoiceItem fromMap(Map<String, dynamic> m) => InvoiceItem.fromJson(m);

  InvoiceItem recalculate({String? sellerState, String? buyerState}) {
    final gross = (unitPrice * quantity).round();
    final discAmt = (gross * discountPct / 100).round();
    final afterDisc = gross - discAmt;
    final int tax;
    if (taxInclusive) {
      tax = (afterDisc - (afterDisc * 100 / (100 + taxRate)).round());
    } else {
      tax = (afterDisc * taxRate / 100).round();
    }
    final total = taxInclusive ? afterDisc : afterDisc + tax;

    // Split stays all-zero whenever sellerState/buyerState are not
    //passed - exactly the non-Indian business case.
    final split = GstSplitCalculator.split(
        sellerState: sellerState, buyerState: buyerState, totalTaxPaise: tax);

    return copyWith(
        taxAmount: tax,
        lineTotal: total,
        cgstAmount: split.cgst,
        sgstAmount: split.sgst,
        igstAmount: split.igst,
        ugstAmount: split.ugst);
  }

//commented to add GST split calculations
  // InvoiceItem recalculate() {
  //   final gross = (unitPrice * quantity).round();
  //   final discAmt = (gross * discountPct / 100).round();
  //   final afterDisc = gross - discAmt;
  //   final int tax;
  //   if (taxInclusive) {
  //     //Tax already inside unit price - extract it
  //     tax = (afterDisc - (afterDisc * 100 / (100 + taxRate)).round());
  //   } else {
  //     //Tax on top of price
  //     tax = (afterDisc * taxRate / 100).round();
  //   }
  //   final total = taxInclusive ? afterDisc : afterDisc + tax;
  //   return copyWith(taxAmount: tax, lineTotal: total);
  // }
//commented to add GST split calculations

  Map<String, dynamic> toInsertMap(String invoiceId, String bizId) => {
        'invoice_id': invoiceId,
        'business_id': bizId,
        'product_id': productId,
        'name': name,
        'description': description,
        'quantity': quantity,
        'unit': unit,
        'unit_price': unitPrice,
        'discount_pct': discountPct,
        'tax_rate': taxRate,
        'tax_inclusive': taxInclusive,
        'tax_amount': taxAmount,
        'line_total': lineTotal,
        'sort_order': sortOrder,
      };
}
