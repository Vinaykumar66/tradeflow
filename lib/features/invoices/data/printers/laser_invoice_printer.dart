import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../core/interfaces/i_invoice_printer.dart';

class LaserInvoicePrinter implements IInvoicePrinter {
  @override
  String get formatKey => kPrintFormatLaser;
  @override
  String get displayName => 'Laser / Inkjet (A4 PDF)';
  @override
  String get iconAssetHint => 'print_outlined';

  @override
  Future<void> print(InvoicePrintJob job) async {
    final inv = job.invoice;
    final biz = job.business;
    final cust = job.customer;

    // Logo is optional - never let a failed logo fetch break printing.
    pw.MemoryImage? logo;
    if (biz.logoUrl != null) {
      try {
        final res = await http.get(Uri.parse(biz.logoUrl!));
        if (res.statusCode == 200) logo = pw.MemoryImage(res.bodyBytes);
      } catch (_) {/* fall back to text-only header below */}
    }

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (ctx) => _buildPage(inv, biz, cust, logo),
    ));

    // Opens the native print dialog - the user selects the actual
    // laser or inkjet printer driver installed on their device.
    await Printing.layoutPdf(
        onLayout: (_) => pdf.save(), name: '${inv.invoiceNumber}.pdf');
  }

  pw.Widget _buildPage(
      dynamic inv, dynamic biz, dynamic cust, pw.MemoryImage? logo) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(children: [
                  if (logo != null) ...[
                    pw.Image(logo, width: 48, height: 48),
                    pw.SizedBox(width: 12),
                  ],
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(biz.name,
                            style: pw.TextStyle(
                                fontSize: 20, fontWeight: pw.FontWeight.bold)),
                        if (biz.address != null) pw.Text(biz.address!),
                      ]),
                ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('INVOICE',
                          style: pw.TextStyle(
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900)),
                      pw.Text(inv.invoiceNumber),
                    ]),
              ]),
          pw.SizedBox(height: 16),
          // Items table + totals: unchanged from Day 29 InvoicePdfGenerator.
          // See Day 29 for the full table and totals rendering code.
        ]);
  }
}
