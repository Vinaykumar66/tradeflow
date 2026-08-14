import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/models/invoice.dart';

class InvoiceLineItemTile extends StatelessWidget {
  final InvoiceItem item;
  final String sym;
  final bool lakh;
  final void Function(InvoiceItem) onUpdate;
  final VoidCallback onDelete;

  const InvoiceLineItemTile({
    super.key,
    required this.item,
    required this.sym,
    required this.lakh,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fmt = (int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);
    return Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
              IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 18),
                  onPressed: onDelete),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              // Quantity stepper
              _label('Qty'),
              const SizedBox(width: 8),
              SizedBox(
                  width: 72,
                  child: TextFormField(
                      initialValue: item.quantity.toString(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                      onChanged: (v) {
                        final q = double.tryParse(v);
                        if (q != null && q > 0)
                          onUpdate(item.copyWith(quantity: q));
                      })),
              const SizedBox(width: 16),
              // Unit price
              _label('Unit Price'),
              const SizedBox(width: 8),
              SizedBox(
                  width: 100,
                  child: TextFormField(
                      initialValue: (item.unitPrice / 100).toStringAsFixed(2),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                      onChanged: (v) {
                        final price = ((double.tryParse(v) ?? 0) * 100).round();
                        onUpdate(item.copyWith(unitPrice: price));
                      })),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              // Tax rate
              _label('Tax %'),
              const SizedBox(width: 8),
              SizedBox(
                  width: 60,
                  child: TextFormField(
                      initialValue: item.taxRate.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                      onChanged: (v) {
                        final r = double.tryParse(v) ?? 0;
                        onUpdate(item.copyWith(taxRate: r));
                      })),
              const SizedBox(width: 8),
              // Tax inclusive toggle
              const Text('Incl.', style: TextStyle(fontSize: 12)),
              Switch(
                  value: item.taxInclusive,
                  onChanged: (v) => onUpdate(item.copyWith(taxInclusive: v))),
              const Spacer(),
              // Line total
              Text(fmt(item.lineTotal),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
          ]),
        ));
  }

  Widget _label(String t) =>
      Text(t, style: const TextStyle(fontSize: 11, color: Colors.grey));
}
