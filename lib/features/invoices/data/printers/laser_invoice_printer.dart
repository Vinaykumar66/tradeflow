import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../core/interfaces/i_invoice_printer.dart';
import '../../../../shared/models/business.dart';
import '../../../../shared/models/customer.dart';
import '../../../../shared/models/invoice.dart';

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

    // Logo is optional — never let a failed fetch break printing.
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

    // Opens the native print dialog — the user selects the actual
    // laser or inkjet printer driver installed on their device.
    await Printing.layoutPdf(
        onLayout: (_) => pdf.save(), name: '${inv.invoiceNumber}.pdf');
  }

  pw.Widget _buildPage(
      Invoice inv, Business biz, Customer? cust, pw.MemoryImage? logo) {
    final showHsnColumn = inv.items.any((i) => i.hsnSacCode != null);
    final showCommodity = inv.items.any((i) => i.commodityCode != null);
    final showSplit =
        inv.cgstTotal + inv.sgstTotal + inv.igstTotal + inv.ugstTotal > 0;

    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      // ── HEADER: logo + business details, invoice title + number ────────
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
                    if (biz.email != null) pw.Text(biz.email!),
                    if (biz.gstin != null) pw.Text('GSTIN: ${biz.gstin}'),
                  ]),
            ]),
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              pw.Text('INVOICE',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),
              pw.Text(inv.invoiceNumber,
                  style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
              pw.Text('Date: ${_fmtDate(inv.issueDate)}'),
              if (inv.dueDate != null)
                pw.Text('Due: ' + _fmtDate(inv.dueDate!)),
            ]),
          ]),
      pw.SizedBox(height: 24),

      // Bill to
      if (cust != null) ...[
        pw.Text('Bill To:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(cust.name),
        if (cust.phone != null) pw.Text(cust.phone!),
        if (cust.gstin != null) pw.Text('GSTIN: ${cust.gstin}'),
        pw.SizedBox(height: 16),
      ],

      // Item table
      pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: showHsnColumn
              ? {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(1.5),
                  2: const pw.FlexColumnWidth(1),
                  3: const pw.FlexColumnWidth(1.5),
                  4: const pw.FlexColumnWidth(1),
                  5: const pw.FlexColumnWidth(1.5),
                }
              : {
                  0: const pw.FlexColumnWidth(4),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(1),
                  4: const pw.FlexColumnWidth(2),
                },
          children: [
            // Header row
            pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.blue900),
                children: [
                  'Item',
                  if (showHsnColumn) 'HSN/SAC',
                  if (showCommodity) 'Cmdty Code',
                  'Qty',
                  'Unit Price',
                  'Tax',
                  'Total',
                ]
                    .map((h) => pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(h,
                            style: pw.TextStyle(
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 10))))
                    .toList()),

            // Item rows
            ...inv.items.map((item) => pw.TableRow(children: [
                  _cell(item.name),
                  if (showHsnColumn) _cell(item.hsnSacCode ?? '-'),
                  if (showCommodity) _cell(item.commodityCode ?? '-'),
                  _cell(item.quantity.toStringAsFixed(0)),
                  _cell(inv.fmt(item.unitPrice)),
                  _cell('${item.taxRate}%${item.taxInclusive ? " incl." : ""}'),
                  _cell(inv.fmt(item.lineTotal)),
                ])),
          ]),
      pw.SizedBox(height: 16),

      // ── Total (right-aligned) ───────────────────────────────────────
      pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                _pdfTotalRow('Subtotal', inv.formattedSubtotal),
                if (inv.discountAmount > 0)
                  _pdfTotalRow('Discount', '-${inv.formattedDiscount}'),

                // GST split — replaces the single Tax row whenever this
                // invoice actually has one. Order matches how it's shown
                // everywhere else in the app: CGST, SGST, UGST, IGST.
                if (showSplit) ...[
                  if (inv.cgstTotal > 0)
                    _pdfTotalRow('CGST', inv.fmt(inv.cgstTotal)),
                  if (inv.sgstTotal > 0)
                    _pdfTotalRow('SGST', inv.fmt(inv.sgstTotal)),
                  if (inv.ugstTotal > 0)
                    _pdfTotalRow('UGST', inv.fmt(inv.ugstTotal)),
                  if (inv.igstTotal > 0)
                    _pdfTotalRow('IGST', inv.fmt(inv.igstTotal)),
                ] else
                  _pdfTotalRow('Tax', inv.formattedTax),

                pw.Divider(),
                _pdfTotalRow('TOTAL', inv.formattedTotal,
                    bold: true, large: true),
                if (inv.amountPaid > 0) ...[
                  _pdfTotalRow('Amount Paid', inv.formattedAmountPaid),
                  _pdfTotalRow('Balance Due', inv.formattedBalanceDue,
                      bold: true, color: PdfColors.red),
                ],
              ])),

      // Notes
      if (inv.notes != null) ...[
        pw.SizedBox(height: 24),
        pw.Text('Notes:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(inv.notes!),
      ],
    ]);
  }

  pw.Widget _cell(String text) => pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 9)));

  pw.Widget _pdfTotalRow(
    String label,
    String value, {
    bool bold = false,
    bool large = false,
    PdfColor? color,
  }) =>
      pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
        pw.SizedBox(
            width: 120,
            child: pw.Text(label,
                style: pw.TextStyle(
                    fontWeight: bold ? pw.FontWeight.bold : null,
                    fontSize: large ? 12 : 10))),
        pw.SizedBox(width: 12),
        pw.Text(value,
            style: pw.TextStyle(
                fontWeight: bold ? pw.FontWeight.bold : null,
                fontSize: large ? 12 : 10,
                color: color)),
      ]);

  String _fmtDate(DateTime d) => '${d.day.toString().padLeft(2, "0")}/'
      '${d.month.toString().padLeft(2, "0")}/${d.year}';
}




// import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:tradeflow/shared/models/business.dart';
// import 'package:tradeflow/shared/models/customer.dart';
// import 'package:tradeflow/shared/models/invoice.dart';
// import '../../../../core/interfaces/i_invoice_printer.dart';

// class LaserInvoicePrinter implements IInvoicePrinter {
//   @override
//   String get formatKey => kPrintFormatLaser;
//   @override
//   String get displayName => 'Laser / Inkjet (A4 PDF)';
//   @override
//   String get iconAssetHint => 'print_outlined';

//   @override
//   Future<void> print(InvoicePrintJob job) async {
//     final inv = job.invoice;
//     final biz = job.business;
//     final cust = job.customer;

//     // Logo is optional - never let a failed logo fetch break printing.
//     pw.MemoryImage? logo;
//     if (biz.logoUrl != null) {
//       try {
//         final res = await http.get(Uri.parse(biz.logoUrl!));
//         if (res.statusCode == 200) logo = pw.MemoryImage(res.bodyBytes);
//       } catch (_) {/* fall back to text-only header below */}
//     }

//     final pdf = pw.Document();
//     pdf.addPage(pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       margin: const pw.EdgeInsets.all(32),
//       build: (ctx) => _buildPage(inv, biz, cust, logo),
//     ));

//     // Opens the native print dialog - the user selects the actual
//     // laser or inkjet printer driver installed on their device.
//     await Printing.layoutPdf(
//         onLayout: (_) => pdf.save(), name: '${inv.invoiceNumber}.pdf');
//   }

//   pw.Widget _buildPage(
//       Invoice inv, Business biz, Customer? cust, pw.MemoryImage? logo) {
    
    
//     return pw.Column(
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Row(children: [
//                   if (logo != null) ...[
//                     pw.Image(logo, width: 48, height: 48),
//                     pw.SizedBox(width: 12),
//                   ],
//                   pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Text(biz.name,
//                             style: pw.TextStyle(
//                                 fontSize: 20, fontWeight: pw.FontWeight.bold)),
//                         if (biz.address != null) pw.Text(biz.address!),
//                       ]),
//                 ]),
//                 pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     children: [
//                       pw.Text('INVOICE',
//                           style: pw.TextStyle(
//                               fontSize: 24,
//                               fontWeight: pw.FontWeight.bold,
//                               color: PdfColors.blue900)),
//                       pw.Text(inv.invoiceNumber),
//                     ]),
//               ]),
//           pw.SizedBox(height: 16),
//           // Items table + totals: unchanged from Day 29 InvoicePdfGenerator.
//           // See Day 29 for the full table and totals rendering code.
//         ]);
//   }
// }
