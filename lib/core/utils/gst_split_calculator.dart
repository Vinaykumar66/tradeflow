const List<String> kIndianUnionTerritories = [
  'Chandigarh',
  'Andaman and Nicobar Islands',
  'Dadra and Nagar Haveli and Daman and Diu',
  'Lakshadweep',
  'Delhi',
  'Jammu and Kashmir',
  'Ladakh',
  'Puducherry',
];

class GstSplit {
  final int cgst, sgst, igst, ugst;
  const GstSplit({this.cgst = 0, this.sgst = 0, this.igst = 0, this.ugst = 0});
  int get total => cgst + sgst + igst + ugst;
}

class GstSplitCalculator {
  static GstSplit split({
    required String? sellerState,
    required String? buyerState,
    required int totalTaxPaise,
  }) {
    if (sellerState == null || buyerState == null) {
      return GstSplit(igst: totalTaxPaise);
    }
    final sameState =
        sellerState.trim().toLowerCase() == buyerState.trim().toLowerCase();

    if (!sameState) {
      return GstSplit(igst: totalTaxPaise);
    }
    final half = totalTaxPaise ~/ 2;
    final remainder = totalTaxPaise - half;

    final isUnionTerritory = kIndianUnionTerritories
        .any((ut) => ut.toLowerCase() == sellerState.trim().toLowerCase());

    return isUnionTerritory
        ? GstSplit(cgst: remainder, ugst: half)
        : GstSplit(cgst: remainder, sgst: half);
  }
}
