import 'package:flutter/material.dart';
import '../../../../core/interfaces/i_invoice_printer.dart';

class PrintFormatPickerSheet {
  static Future<String?> show(BuildContext context, String currentDefault) {
    return showModalBottomSheet<String>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => SafeArea(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Print As',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16))),
              _tile(context, kPrintFormatLaser, 'Laser / Inkjet',
                  Icons.print_outlined, currentDefault),
              _tile(context, kPrintFormatThermal, 'Thermal Receipt',
                  Icons.receipt_long_outlined, currentDefault),
              _tile(context, kPrintFormatDotMatrix, 'Dot Matrix',
                  Icons.table_rows_outlined, currentDefault),
              const SizedBox(height: 8),
            ])));
  }

  static Widget _tile(BuildContext context, String key, String label,
          IconData icon, String currentDefault) =>
      ListTile(
          leading: Icon(icon),
          title: Text(label),
          trailing: key == currentDefault
              ? const Text('Default',
                  style: TextStyle(color: Colors.grey, fontSize: 12))
              : null,
          onTap: () => Navigator.pop(context, key));
}
