import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../core/interfaces/i_invoice_printer.dart';

class DotMatrixInvoicePrinter implements IInvoicePrinter {
  @override
  String get formatKey => kPrintFormatDotMatrix;
  @override
  String get displayName => 'Dot Matrix';
  @override
  String get iconAssetHint => 'table_rows_outlined';

  @override
  Future<void> print(InvoicePrintJob job) async {
    final inv = job.invoice;
    final biz = job.business;
    final topLines = biz.dotMatrixTopMarginLines;
    final leftChars = biz.dotMatrixLeftMarginChars;

    final font = await PdfGoogleFonts.courierPrimeRegular();
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(8),
        build: (ctx) => pw.DefaultTextStyle(
            style: pw.TextStyle(font: font, fontSize: 10),
            child: pw.Padding(
                padding: pw.EdgeInsets.only(
                    top: topLines * 12.0, left: leftChars * 6.0),
                child: _buildLines(inv, biz)))));
    await Printing.layoutPdf(
        onLayout: (_) => pdf.save(),
        name: '${inv.invoiceNumber}_dotmatrix.pdf');
  }

  pw.Widget _buildLines(dynamic inv, dynamic biz) {
    final lines = <pw.Widget>[];
    lines.add(pw.Text(_padRight(biz.name, 40) + inv.invoiceNumber));
    lines.add(pw.SizedBox(height: 8));
    lines.add(pw.Text(_padRight('ITEM', 24) +
        _padRight('QTY', 6) +
        _padRight('PRICE', 10) +
        'TOTAL'));
    lines.add(pw.Text('-' * 60));
    for (final item in inv.items) {
      lines.add(pw.Text(_padRight(item.name, 24) +
          _padRight(item.quantity.toStringAsFixed(0), 6) +
          _padRight(inv.fmt(item.unitPrice), 10) +
          inv.fmt(item.lineTotal)));
    }
    lines.add(pw.Text('-' * 60));
    lines.add(pw.Text(_padRight('TOTAL', 40) + inv.formattedTotal));
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start, children: lines);
  }

  String _padRight(String s, int width) =>
      s.length >= width ? s.substring(0, width) : s.padRight(width);
}
