import 'package:flutter/material.dart';
import 'package:tradeflow/core/utils/currency_formatter.dart';
import 'package:tradeflow/core/utils/tax_math.dart';

class ProductTaxPreview extends StatelessWidget {
  final int pricePaise;
  final double rate;
  final bool inclusive;
  final String sym, taxLabel;
  final bool lakh, india;
  final String? businessState;
  const ProductTaxPreview(
      {super.key,
      required this.pricePaise,
      required this.rate,
      required this.inclusive,
      required this.sym,
      required this.taxLabel,
      required this.lakh,
      required this.india,
      this.businessState});

  String _r(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();

  @override
  Widget build(BuildContext context) {
    if (pricePaise <= 0 || rate <= 0) return const SizedBox.shrink();
    String m(int p) => CurrencyFormatter.format(p, sym: sym, lakh: lakh).trim();
    final b = taxBreakup(
        pricePaise: pricePaise,
        ratePct: rate,
        inclusive: inclusive,
        businessState: businessState,
        india: india);
    final s = b.sameState;
    final rows = <(String, String, bool)>[
      ('Price before tax', m(b.base), false),
      if (india && s.cgst > 0) ('CGST ${_r(rate / 2)}%', m(s.cgst), false),
      if (india && s.sgst > 0) ('SGST ${_r(rate / 2)}%', m(s.sgst), false),
      if (india && s.ugst > 0) ('UGST ${_r(rate / 2)}%', m(s.ugst), false),
      if (!india) ('$taxLabel ${_r(rate)}%', m(b.tax), false),
      (
        inclusive
            ? 'Customer pays (tax included)'
            : 'Customer pays (tax added)',
        m(b.total),
        true
      ),
    ];
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (final r in rows)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(children: [
                Text(r.$1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            r.$3 ? FontWeight.bold : FontWeight.normal)),
                const Spacer(),
                Text(r.$2,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            r.$3 ? FontWeight.bold : FontWeight.normal)),
              ])),
        if (india)
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                  'Sold to a customer in another state: IGST ${_r(rate)}% = ${m(b.tax)}',
                  style: const TextStyle(fontSize: 11, color: Colors.grey))),
      ]),
    );
  }
}
