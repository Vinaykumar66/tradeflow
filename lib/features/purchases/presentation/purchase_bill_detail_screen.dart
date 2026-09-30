import 'package:flutter/material.dart';
import '../../../shared/models/purchase_bill.dart';

class PurchaseBillDetailScreen extends StatelessWidget {
  final PurchaseBill bill;
  const PurchaseBillDetailScreen({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(bill.billNumber)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text(
            'Bill Date: ${bill.billDate.day}/${bill.billDate.month}/${bill.billDate.year}'),
        const Divider(height: 32),
        Text('Items', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...bill.items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(children: [
              Expanded(flex: 3, child: Text(item.name)),
              Expanded(
                  flex: 1,
                  child: Text(item.quantity.toStringAsFixed(0),
                      textAlign: TextAlign.center)),
              Expanded(
                  flex: 2,
                  child: Text('Rs.${(item.lineTotal / 100).toStringAsFixed(2)}',
                      textAlign: TextAlign.right)),
            ]))),
        const Divider(height: 32),
        if (bill.cgstTotal > 0) _row('CGST', bill.cgstTotal),
        if (bill.cgstTotal > 0) _row('SGST', bill.sgstTotal),
        if (bill.igstTotal > 0) _row('IGST', bill.igstTotal),
        if (bill.ugstTotal > 0) _row('UGST', bill.ugstTotal),
        const Divider(),
        _row('Total', bill.total, bold: true),
      ]),
    );
  }

  Widget _row(String label, int amountPaise, {bool bold = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Text(label,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        const Spacer(),
        Text('₹. ${(amountPaise / 100).toStringAsFixed(2)}',
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ]));
}
