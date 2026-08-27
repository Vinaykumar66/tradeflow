import '../../shared/models/business.dart';
import '../../shared/models/customer.dart';
import '../../shared/models/invoice.dart';

const kPrintFormatLaser = 'laser';
const kPrintFormatThermal = 'thermal';
const kPrintFormatDotMatrix = 'dot_matrix';

// Everything a printer implementation needs to produce an invoice.
// Bundled into one object so the interface never needs to change
// shape when a new format needs one more piece of data.
class InvoicePrintJob {
  final Invoice invoice;
  final Business business;
  final Customer? customer;
  const InvoicePrintJob({
    required this.invoice,
    required this.business,
    this.customer,
  });
}

abstract interface class IInvoicePrinter {
  // Machine key stored in businesses.default_print_format,
  // e.g. 'laser', 'thermal', 'dot_matrix'.
  String get formatKey;

  // label shown in settings and the picker sheet.
  String get displayName;

  // Icon shown next to the format in pickers.
  String get iconAssetHint;

  // Produce and print (or open a share/print dialog for) the invoice.
  Future<void> print(InvoicePrintJob job);
}
