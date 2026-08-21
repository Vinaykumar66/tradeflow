import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../shared/models/invoice.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/models/business.dart';

class InvoicePdfGenerator {
  static const _titles = {
    kDocTypeInvoice: 'INVOICE',
    kDocTypeProforma: 'PROFORMA INVOICE',
    kDocTypeEstimate: 'ESTIMATE',
    kDocTypeQuotation: 'QUOTATION',
  };

  static const _disclaimers = {
    kDocTypeProforma: 'This is a proforma invoice, not a tax invoice.',
    kDocTypeEstimate: 'This is an estimate only, not a demand for payment.',
    kDocTypeQuotation:
        'This quotation is valid for 30 days from the issue date.',
  };

  /// Generate and share/print the invoice PDF.
  static Future<void> generate({
    required Invoice invoice,
    required Business business,
    Customer? customer,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (ctx) => _buildPage(ctx, invoice, business, customer),
    ));
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: '${invoice.invoiceNumber}.pdf');
  }

  static pw.Widget _buildPage(
      pw.Context ctx, Invoice inv, Business biz, Customer? cust) {
    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      // Header
      pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
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
            pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
              pw.Text(_titles[inv.documentType] ?? 'INVOICE',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900)),

              // pw.Text('INVOICE',
              //     style: pw.TextStyle(
              //         fontSize: 24,
              //         fontWeight: pw.FontWeight.bold,
              //         color: PdfColors.blue900)),
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

      // Items table
      pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          columnWidths: {
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
                children: ['Item', 'Qty', 'Unit Price', 'Tax', 'Total']
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
                  _cell(item.quantity.toString()),
                  _cell(inv.fmt(item.unitPrice)),
                  _cell('${item.taxRate}%${item.taxInclusive ? " incl." : ""}'),
                  _cell(inv.fmt(item.lineTotal)),
                ])),
          ]),
      pw.SizedBox(height: 16),

      // Totals (right-aligned)
      pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                _totalLine('Subtotal', inv.formattedSubtotal),
                if (inv.discountAmount > 0)
                  _totalLine('Discount', '-${inv.formattedDiscount}'),
                _totalLine('Tax', inv.formattedTax),
                pw.Divider(),
                _totalLine('TOTAL', inv.formattedTotal,
                    bold: true, large: true),
                if (inv.amountPaid > 0) ...[
                  _totalLine('Amount Paid', inv.formattedAmountPaid),
                  _totalLine('Balance Due', inv.formattedBalanceDue,
                      bold: true, color: PdfColors.red),
                ],
              ])),

      if (_disclaimers[inv.documentType] != null) ...[
        pw.SizedBox(height: 12),
        pw.Text(_disclaimers[inv.documentType]!,
            style: pw.TextStyle(
                fontSize: 9,
                fontStyle: pw.FontStyle.italic,
                color: PdfColors.grey700)),
      ],

      // Notes
      if (inv.notes != null) ...[
        pw.SizedBox(height: 24),
        pw.Text('Notes:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(inv.notes!),
      ],
    ]);
  }

  static pw.Widget _cell(String text) => pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 9)));

  static pw.Widget _totalLine(String label, String value,
          {bool bold = false, bool large = false, PdfColor? color}) =>
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

  static String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, "0")}/${d.month.toString().padLeft(2, "0")}/${d.year}';
}
