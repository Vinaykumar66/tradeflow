import 'package:flutter/material.dart';
import '../../../../shared/models/invoice.dart';

class InvoiceStatusBadge extends StatelessWidget {
  final String status;
  final bool overdue;
  const InvoiceStatusBadge(
      {super.key, required this.status, this.overdue = false});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = _style();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(label,
            style: TextStyle(
                color: fg, fontSize: 11, fontWeight: FontWeight.bold)));
  }

  (String, Color, Color) _style() {
    if (overdue) return ('OVERDUE', Colors.red.shade100, Colors.red.shade800);
    return switch (status) {
      kStatusDraft => ('DRAFT', Colors.grey.shade200, Colors.grey.shade700),
      kStatusSent => ('SENT', Colors.blue.shade100, Colors.blue.shade800),
      kStatusPaid => ('PAID', Colors.green.shade100, Colors.green.shade800),
      kStatusPartial => (
          'PARTIAL',
          Colors.orange.shade100,
          Colors.orange.shade800
        ),
      kStatusCancelled => (
          'CANCELLED',
          Colors.red.shade50,
          Colors.red.shade400
        ),
      _ => ('UNKNOWN', Colors.grey, Colors.white),
    };
  }
}
