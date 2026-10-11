import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/gst_report_providers.dart';
import '../data/csv_export_service.dart';
import '../presentation/widget/gst_period_picker.dart';

class Gstr3bSummaryScreen extends ConsumerWidget {
  const Gstr3bSummaryScreen({super.key});
  String _rs(int v) =>
      '${v < 0 ? '-' : ''}Rs.${(v.abs() / 100).toStringAsFixed(2)}';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(gstReportPeriodNotifierProvider);
    //commented on 07/10/2026
    // final invoicesAsync = ref.watch(outwardSuppliesProvider);
    // final purchasesAsync = ref.watch(inputPurchasesProvider);
    //commented on 07/10/2026

    final dataAsync = ref.watch(gstr3bDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('GSTR-3B - Tax Liability')),
      body: dataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (d) {
          final invoices = d.invoices;
          final bills = d.bills;
          final creditNotes = d.creditNotes;

          // Output tax, from sales invoices
          var taxable = 0, cgst = 0, sgst = 0, igst = 0, ugst = 0, total = 0;
          for (final inv in invoices) {
            taxable += inv.subtotal;
            cgst += inv.cgstTotal;
            sgst += inv.sgstTotal;
            igst += inv.igstTotal;
            ugst += inv.ugstTotal;
            total += inv.total;
          }

          // Credit notes reduce taxable value and output tax
          var cnTaxable = 0, cnTax = 0;
          for (final c in creditNotes) {
            cnTaxable += c.subtotal;
            cnTax += c.cgstTotal + c.sgstTotal + c.igstTotal + c.ugstTotal;
          }

          // Input tax credit, from purchase bills
          var inCgst = 0, inSgst = 0, inIgst = 0, inUgst = 0;
          for (final b in bills) {
            inCgst += b.cgstTotal;
            inSgst += b.sgstTotal;
            inIgst += b.igstTotal;
            inUgst += b.ugstTotal;
          }
          final totalInputTax = inCgst + inSgst + inIgst + inUgst;

          final taxLiability = cgst + sgst + igst + ugst;
          final netTaxable = taxable - cnTaxable;
          final netOutputTax = taxLiability - cnTax;
          final netPayable = netOutputTax - totalInputTax;

          return ListView(padding: const EdgeInsets.all(16), children: [
            GstPeriodPicker(
                label: period.label,
                onPrevious: () => ref
                    .read(gstReportPeriodNotifierProvider.notifier)
                    .previous(),
                onNext: () =>
                    ref.read(gstReportPeriodNotifierProvider.notifier).next()),
            const SizedBox(height: 20),
            _row('Total Invoices', '${invoices.length}'),
            _row('Credit Notes', '${creditNotes.length}'),
            _row('Purchase Bills', '${bills.length}'),
            const Divider(),
            _row('CGST (Output)', _rs(cgst)),
            _row('SGST (Output)', _rs(sgst)),
            _row('IGST (Output)', _rs(igst)),
            _row('UGST (Output)', _rs(ugst)),
            const Divider(),
            _row('Taxable Value (Sales)', _rs(taxable)),
            _row('Less: Credit Notes', '-${_rs(cnTaxable)}'),
            _row('Net Taxable Value', _rs(netTaxable), bold: true),
            const Divider(),
            _row('Output Tax (Sales)', _rs(taxLiability)),
            _row('Less: Credit Notes (Tax)', '-${_rs(cnTax)}'),
            _row('Net Output Tax', _rs(netOutputTax)),
            _row('Input Tax Credit (Purchases)', '-${_rs(totalInputTax)}'),
            const Divider(),
            _row('Net Tax Payable', _rs(netPayable), bold: true),
            const SizedBox(height: 8),
            _row('Invoice Value (before credit notes)', _rs(total)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
                icon: const Icon(Icons.download_outlined),
                label: const Text('Export CSV'),
                onPressed: () => _export(
                    period.label,
                    invoices.length,
                    bills.length,
                    taxable,
                    cgst,
                    sgst,
                    igst,
                    ugst,
                    total,
                    inCgst,
                    inSgst,
                    inIgst,
                    inUgst,
                    netPayable,
                    cnTax)),
            const SizedBox(height: 32),
          ]);
        },
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Text(label,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        const Spacer(),
        Text(value,
            style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: bold ? 16 : 14)),
      ]));

  Future<void> _export(
    String periodLabel,
    int invCount,
    int billCount,
    int taxable,
    int cgst,
    int sgst,
    int igst,
    int ugst,
    int total,
    int inputCgst,
    int inputSgst,
    int inputIgst,
    int inputUgst,
    int netPayable,
    int cnTax,
  ) async {
    final rows = [
      ['Metric', 'Value'],
      ['Total Invoices', invCount.toString()],
      ['Purchase Bills', billCount.toString()],
      ['Taxable Value (Sales)', (taxable / 100).toStringAsFixed(2)],
      ['CGST (Output)', (cgst / 100).toStringAsFixed(2)],
      ['SGST (Output)', (sgst / 100).toStringAsFixed(2)],
      ['IGST (Output)', (igst / 100).toStringAsFixed(2)],
      ['UGST (Output)', (ugst / 100).toStringAsFixed(2)],
      ['CGST (Input Credit)', (inputCgst / 100).toStringAsFixed(2)],
      ['SGST (Input Credit)', (inputSgst / 100).toStringAsFixed(2)],
      ['IGST (Input Credit)', (inputIgst / 100).toStringAsFixed(2)],
      ['UGST (Input Credit)', (inputUgst / 100).toStringAsFixed(2)],
      ['Credit Notes (Tax)', (cnTax / 100).toStringAsFixed(2)],
      ['Net Tax Payable', (netPayable / 100).toStringAsFixed(2)],
      ['Total Invoice Value', (total / 100).toStringAsFixed(2)],
    ];
    await CsvExportService.exportAndShare(
        fileName: 'GSTR3B_$periodLabel.csv'.replaceAll(' ', '_'), rows: rows);
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../application/gst_report_providers.dart';
// import '../data/csv_export_service.dart';
// import '../presentation/widget/gst_period_picker.dart';
// import '../../purchases/data/purchase_bill_repository.dart';

// class Gstr3bSummaryScreen extends ConsumerWidget {
//   const Gstr3bSummaryScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final period = ref.watch(gstReportPeriodNotifierProvider);
//     final invoicesAsync = ref.watch(outwardSuppliesProvider);

//     return Scaffold(
//       appBar: AppBar(
//           iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
//           backgroundColor: const Color(0xF0FFFFFF),
//           title: const Text(
//               style: TextStyle(color: Color(0xFF2F4F4F)),
//               'GSTR-3B Tax Liability')),
//       body: invoicesAsync.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text('Error: $e')),
//         data: (invoices) {
//           var taxable = 0, cgst = 0, sgst = 0, igst = 0, ugst = 0, total = 0;
//           for (final inv in invoices) {
//             taxable += inv.subtotal;
//             cgst += inv.cgstTotal;
//             sgst += inv.sgstTotal;
//             igst += inv.igstTotal;
//             ugst += inv.ugstTotal;
//             total += inv.total;
//           }
//           final taxLiability = cgst + sgst + igst + ugst;

//           return ListView(padding: const EdgeInsets.all(16), children: [
//             GstPeriodPicker(
//                 label: period.label,
//                 onPrevious: () => ref
//                     .read(gstReportPeriodNotifierProvider.notifier)
//                     .previous(),
//                 onNext: () =>
//                     ref.read(gstReportPeriodNotifierProvider.notifier).next()),
//             const SizedBox(height: 20),
//             _row('Total Invoices', '${invoices.length}'),
//             _row('Taxable Value', 'Rs.${(taxable / 100).toStringAsFixed(2)}'),
//             const Divider(),
//             _row('CGST', 'Rs.${(cgst / 100).toStringAsFixed(2)}'),
//             _row('SGST', 'Rs.${(sgst / 100).toStringAsFixed(2)}'),
//             _row('IGST', 'Rs.${(igst / 100).toStringAsFixed(2)}'),
//             _row('UGST', 'Rs.${(ugst / 100).toStringAsFixed(2)}'),
//             const Divider(),
//             _row('Total Tax Liability',
//                 'Rs.${(taxLiability / 100).toStringAsFixed(2)}',
//                 bold: true),
//             _row(
//                 'Total Invoice Value', 'Rs.${(total / 100).toStringAsFixed(2)}',
//                 bold: true),
//             const SizedBox(height: 24),
//             Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: const Row(children: [
//                   Icon(Icons.info_outline, color: Colors.blue, size: 18),
//                   SizedBox(width: 8),
//                   Expanded(
//                       child: Text(
//                           'This covers outward tax liabiliity only. Input Tax Credit from purchases is not tracked and must be added separately when filing.',
//                           style: TextStyle(fontSize: 12))),
//                 ])),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//                 icon: const Icon(Icons.download_outlined),
//                 label: const Text('Export CSV'),
//                 onPressed: () => _export(period.label, invoices.length, taxable,
//                     cgst, sgst, igst, ugst, total)),
//             const SizedBox(height: 32),
//           ]);
//         },
//       ),
//     );
//   }

//   Widget _row(String label, String value, {bool bold = false}) => Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(children: [
//         Text(label,
//             style: TextStyle(
//                 fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
//         const Spacer(),
//         Text(value,
//             style: TextStyle(
//                 fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                 fontSize: bold ? 16 : 14)),
//       ]));

//   Future<void> _export(String periodLabel, int count, int taxable, int cgst,
//       int sgst, int igst, int ugst, int total) async {
//     final rows = [
//       ['Metric', 'Value'],
//       ['Total Invoices', count.toString()],
//       ['Taxable Value', (taxable / 100).toStringAsFixed(2)],
//       ['CGST', (cgst / 100).toStringAsFixed(2)],
//       ['SGST', (sgst / 100).toStringAsFixed(2)],
//       ['IGST', (igst / 100).toStringAsFixed(2)],
//       ['UGST', (ugst / 100).toStringAsFixed(2)],
//       [
//         'Total Tax Liability',
//         ((cgst + sgst + igst + ugst) / 100).toStringAsFixed(2)
//       ],
//       ['Total Invoice Value', (total / 100).toStringAsFixed(2)],
//     ];

//     await CsvExportService.exportAndShare(
//         fileName: 'GSTR3B_$periodLabel.csv'.replaceAll(' ', '_'), rows: rows);
//   }
// }
