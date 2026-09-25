import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/gst_report_providers.dart';
import '../data/csv_export_service.dart';
import '../presentation/widget/gst_period_picker.dart';

class Gstr3bSummaryScreen extends ConsumerWidget {
  const Gstr3bSummaryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(gstReportPeriodNotifierProvider);
    final invoicesAsync = ref.watch(outwardSuppliesProvider);

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
          backgroundColor: const Color(0xF0FFFFFF),
          title: const Text(
              style: TextStyle(color: Color(0xFF2F4F4F)),
              'GSTR-3B Tax Liability')),
      body: invoicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (invoices) {
          var taxable = 0, cgst = 0, sgst = 0, igst = 0, ugst = 0, total = 0;
          for (final inv in invoices) {
            taxable += inv.subtotal;
            cgst += inv.cgstTotal;
            sgst += inv.sgstTotal;
            igst += inv.igstTotal;
            ugst += inv.ugstTotal;
            total += inv.total;
          }
          final taxLiability = cgst + sgst + igst + ugst;
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
            _row('Taxable Value', 'Rs.${(taxable / 100).toStringAsFixed(2)}'),
            const Divider(),
            _row('CGST', 'Rs.${(cgst / 100).toStringAsFixed(2)}'),
            _row('SGST', 'Rs.${(sgst / 100).toStringAsFixed(2)}'),
            _row('IGST', 'Rs.${(igst / 100).toStringAsFixed(2)}'),
            _row('UGST', 'Rs.${(ugst / 100).toStringAsFixed(2)}'),
            const Divider(),
            _row('Total Tax Liability',
                'Rs.${(taxLiability / 100).toStringAsFixed(2)}',
                bold: true),
            _row(
                'Total Invoice Value', 'Rs.${(total / 100).toStringAsFixed(2)}',
                bold: true),
            const SizedBox(height: 24),
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8)),
                child: const Row(children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                      child: Text(
                          'This covers outward tax liabiliity only. Input Tax Credit from purchases is not tracked and must be added separately when filing.',
                          style: TextStyle(fontSize: 12))),
                ])),
            const SizedBox(height: 20),
            ElevatedButton.icon(
                icon: const Icon(Icons.download_outlined),
                label: const Text('Export CSV'),
                onPressed: () => _export(period.label, invoices.length, taxable,
                    cgst, sgst, igst, ugst, total)),
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

  Future<void> _export(String periodLabel, int count, int taxable, int cgst,
      int sgst, int igst, int ugst, int total) async {
    final rows = [
      ['Metric', 'Value'],
      ['Total Invoices', count.toString()],
      ['Taxable Value', (taxable / 100).toStringAsFixed(2)],
      ['CGST', (cgst / 100).toStringAsFixed(2)],
      ['SGST', (sgst / 100).toStringAsFixed(2)],
      ['IGST', (igst / 100).toStringAsFixed(2)],
      ['UGST', (ugst / 100).toStringAsFixed(2)],
      [
        'Total Tax Liability',
        ((cgst + sgst + igst + ugst) / 100).toStringAsFixed(2)
      ],
      ['Total Invoice Value', (total / 100).toStringAsFixed(2)],
    ];
    await CsvExportService.exportAndShare(
        fileName: 'GSTR3B_$periodLabel.csv'.replaceAll(' ', '_'), rows: rows);
  }
}
