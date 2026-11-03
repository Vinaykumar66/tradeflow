import 'gst_split_calculator.dart';

class TaxBreakup {
  final int base, tax, total;
  final GstSplit sameState;
  const TaxBreakup(
      {required this.base,
      required this.tax,
      required this.total,
      required this.sameState});
}

TaxBreakup taxBreakup({
  required int pricePaise,
  required double ratePct,
  required bool inclusive,
  String? businessState,
  bool india = true,
}) {
  final int base, tax;
  if (inclusive) {
    base = (pricePaise * 100 / (100 + ratePct)).round();
    tax = pricePaise - base;
  } else {
    base = pricePaise;
    tax = (pricePaise * ratePct / 100).round();
  }
  final st =
      (businessState ?? '').trim().isEmpty ? 'preview' : businessState!.trim();
  return TaxBreakup(
      base: base,
      tax: tax,
      total: base + tax,
      sameState: india
          ? GstSplitCalculator.split(
              sellerState: st, buyerState: st, totalTaxPaise: tax)
          : const GstSplit());
}
