// lib/features/invoices/data/printers/invoice_printer_registry.dart
//
// One place that knows how to turn a format key into the correct
// printer instance. Nothing else in the app should ever
// instantiate LaserInvoicePrinter / ThermalInvoicePrinter /
// DotMatrixInvoicePrinter directly — always go through this.

import '../../../../core/interfaces/i_invoice_printer.dart';
import 'laser_invoice_printer.dart';
import 'thermal_invoice_printer.dart';
import 'dot_matrix_invoice_printer.dart';

IInvoicePrinter invoicePrinterFor(String formatKey) => switch (formatKey) {
      kPrintFormatThermal => ThermalInvoicePrinter(),
      kPrintFormatDotMatrix => DotMatrixInvoicePrinter(),
      _ => LaserInvoicePrinter(), // laser is the safe default
    };
