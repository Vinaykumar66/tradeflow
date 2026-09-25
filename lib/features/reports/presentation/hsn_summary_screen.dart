import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/gst_report_providers.dart';
import '../data/csv_export_service.dart';
import '../presentation/widget/gst_period_picker.dart';

class _HsnRow {
  double quantity = 0;
  int taxable = 0;
  int cgst = 0;
  int sgst = 0;
  int igst = 0;
  int ugst = 0;
}

class HsnSummaryScreen extends ConsumerWidget {
  const HsnSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(gstReportPeriodNotifierProvider);
    final invoicesAsync = ref.watch(outwardSuppliesProvider);

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
          backgroundColor: const Color(0xF0FFFFFF),
          title: const Text(
              style: TextStyle(color: Color(0xFF2F4F4F)), 'HSN/SAC Summary')),
      body: invoicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (invoices) {
          final byHsn = <String, _HsnRow>{};
          var missingCount = 0;

          for (final inv in invoices) {
            for (final item in inv.items) {
              final key = item.hsnSacCode ?? 'Not Specified';
              if (item.hsnSacCode == null) {
                missingCount++;
              }
              final r = byHsn.putIfAbsent(key, () => _HsnRow());
              r.quantity += item.quantity;
              r.taxable += (item.lineTotal - item.taxAmount);
              r.cgst += item.cgstAmount;
              r.sgst += item.sgstAmount;
              r.igst += item.igstAmount;
              r.ugst += item.ugstAmount;
            }
          }

          return ListView(padding: const EdgeInsets.all(16), children: [
            GstPeriodPicker(
                label: period.label,
                onPrevious: () => ref
                    .read(gstReportPeriodNotifierProvider.notifier)
                    .previous(),
                onNext: () =>
                    ref.read(gstReportPeriodNotifierProvider.notifier).next()),
            const SizedBox(height: 16),
            if (missingCount > 0)
              Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    const Icon(Icons.warning_amber_outlined,
                        color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            '$missingCount line item(s) have no HSN/SAC code set.'
                            'Add codes in Catalog for an accurate filing.',
                            style: const TextStyle(fontSize: 12))),
                  ])),
            ...byHsn.entries.map((e) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.key,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                              'Qty: ${e.value.quantity.toStringAsFixed(0)}  |'
                              'Taxable: Rs.  ${(e.value.taxable / 100).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          Text(
                              'CGST:  ${(e.value.cgst / 100).toStringAsFixed(2)} '
                              'SGST:  ${(e.value.sgst / 100).toStringAsFixed(2)} '
                              'IGST:  ${(e.value.igst / 100).toStringAsFixed(2)} '
                              'UGST:  ${(e.value.ugst / 100).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ])))),
            const SizedBox(height: 20),
            ElevatedButton.icon(
                icon: const Icon(Icons.download_outlined),
                label: const Text('Export CSV'),
                onPressed: () => _export(period.label, byHsn)),
            const SizedBox(height: 32),
          ]);
        },
      ),
    );
  }

  Future<void> _export(String periodLabel, Map<String, _HsnRow> byHsn) async {
    final rows = <List<String>>[
      ['HSN/SAC', 'Quantity', 'Taxable Value', 'CGST', 'SGST', 'IGST', 'UGST'],
      ...byHsn.entries.map((e) => [
            e.key,
            e.value.quantity.toStringAsFixed(0),
            (e.value.taxable / 100).toStringAsFixed(2),
            (e.value.cgst / 100).toStringAsFixed(2),
            (e.value.sgst / 100).toStringAsFixed(2),
            (e.value.igst / 100).toStringAsFixed(2),
            (e.value.ugst / 100).toStringAsFixed(2),
          ]),
    ];
    await CsvExportService.exportAndShare(
        fileName: 'HSN_Summary_$periodLabel.csv'.replaceAll(' ', '_'),
        rows: rows);
  }
}
