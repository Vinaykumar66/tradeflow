import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../shared/models/invoice.dart';
import '../application/gst_report_providers.dart';
import '../data/csv_export_service.dart';
import '../presentation/widget/gst_period_picker.dart';

class Gstr1ReportScreen extends ConsumerWidget {
  const Gstr1ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(gstReportPeriodNotifierProvider);
    final invoicesAsync = ref.watch(outwardSuppliesProvider);
    final notesAsync = ref.watch(creditNotesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('GSTR-1 - Outward Supplies')),
      body: invoicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (invoices) => notesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (creditNotes) {
            final b2b = invoices.where((i) => i.customerGstin != null).toList();
            final b2c = invoices.where((i) => i.customerGstin == null).toList();

            final b2cByRate = <double, int>{};
            for (final inv in b2c) {
              for (final item in inv.items) {
                b2cByRate[item.taxRate] =
                    (b2cByRate[item.taxRate] ?? 0) + item.lineTotal;
              }
            }

            // CDNR — registered buyer, invoice-wise, matches GSTR-1's own shape
            final cdnr =
                creditNotes.where((c) => c.customerGstin != null).toList();
            // CDNUR — unregistered buyer, aggregated by tax rate like B2C
            final cdnur =
                creditNotes.where((c) => c.customerGstin == null).toList();
            final cdnurByRate = <double, int>{};
            for (final note in cdnur) {
              for (final item in note.items) {
                cdnurByRate[item.taxRate] =
                    (cdnurByRate[item.taxRate] ?? 0) + item.lineTotal;
              }
            }

            return ListView(padding: const EdgeInsets.all(16), children: [
              GstPeriodPicker(
                  label: period.label,
                  onPrevious: () => ref
                      .read(gstReportPeriodNotifierProvider.notifier)
                      .previous(),
                  onNext: () => ref
                      .read(gstReportPeriodNotifierProvider.notifier)
                      .next()),
              const SizedBox(height: 16),

              Row(children: [
                Expanded(
                    child: _summaryCard('B2B Invoices', '${b2b.length}',
                        Icons.business_outlined)),
                const SizedBox(width: 12),
                Expanded(
                    child: _summaryCard(
                        'B2C Invoices', '${b2c.length}', Icons.person_outline)),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: _summaryCard('CDNR Notes', '${cdnr.length}',
                        Icons.assignment_return_outlined)),
                const SizedBox(width: 12),
                Expanded(
                    child: _summaryCard('CDNUR Notes', '${cdnur.length}',
                        Icons.assignment_return_outlined)),
              ]),
              const SizedBox(height: 20),

              Text('B2B - Invoice-wise',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              if (b2b.isEmpty)
                const Text('No B2B invoices this period',
                    style: TextStyle(color: Colors.grey))
              else
                ...b2b.map((inv) => _invoiceTile(inv)),
              const SizedBox(height: 20),

              Text('B2C - Summary by Tax Rate',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              if (b2cByRate.isEmpty)
                const Text('No B2C invoices this period',
                    style: TextStyle(color: Colors.grey))
              else
                ...b2cByRate.entries.map((e) => ListTile(
                    title: Text('${e.key}% rate'),
                    trailing:
                        Text('Rs.${(e.value / 100).toStringAsFixed(2)}'))),
              const SizedBox(height: 20),

              // ── NEW Day 73 ──────────────────────────────────────────────
              Text('CDNR - Credit Notes (Registered)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              if (cdnr.isEmpty)
                const Text('No registered credit notes this period',
                    style: TextStyle(color: Colors.grey))
              else
                ...cdnr.map((note) => Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: ListTile(
                        title: Text(note.invoiceNumber),
                        subtitle: Text(
                            'Against ${note.originalInvoiceNumber ?? "-"}  |  GSTIN: ${note.customerGstin}',
                            style: const TextStyle(fontSize: 12)),
                        trailing: Text(
                            '-Rs.${(note.total / 100).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red))))),
              const SizedBox(height: 20),

              Text('CDNUR - Credit Notes (Unregistered)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              if (cdnurByRate.isEmpty)
                const Text('No unregistered credit notes this period',
                    style: TextStyle(color: Colors.grey))
              else
                ...cdnurByRate.entries.map((e) => ListTile(
                    title: Text('${e.key}% rate'),
                    trailing: Text('-Rs.${(e.value / 100).toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.red)))),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Export CSV'),
                  onPressed: () =>
                      _export(period.label, b2b, b2cByRate, cdnr, cdnurByRate)),
              const SizedBox(height: 32),
            ]);
          },
        ),
      ),
    );
  }

  Widget _invoiceTile(Invoice inv) => Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
          title: Text(inv.invoiceNumber),
          subtitle: Text(
              'GSTIN: ${inv.customerGstin}  |  ${inv.customerName ?? ''}',
              style: const TextStyle(fontSize: 12)),
          trailing: Text(
              CurrencyFormatter.format(inv.total,
                  sym: inv.currencySymbol, lakh: inv.useLakhFormat),
              style: const TextStyle(fontWeight: FontWeight.bold))));

  Widget _summaryCard(String label, String value, IconData icon) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ]));

  Future<void> _export(
      String periodLabel,
      List<Invoice> b2b,
      Map<double, int> b2cByRate,
      List<Invoice> cdnr,
      Map<double, int> cdnurByRate) async {
    final rows = <List<String>>[
      [
        'Type',
        'Invoice/Note No',
        'Against',
        'GSTIN',
        'Customer',
        'Place of Supply',
        'Taxable Value',
        'CGST',
        'SGST',
        'IGST',
        'UGST',
        'Total'
      ],
      ...b2b.map((inv) => [
            'B2B',
            inv.invoiceNumber,
            '-',
            inv.customerGstin ?? '',
            inv.customerName ?? '',
            inv.placeOfSupply ?? '',
            (inv.subtotal / 100).toStringAsFixed(2),
            (inv.cgstTotal / 100).toStringAsFixed(2),
            (inv.sgstTotal / 100).toStringAsFixed(2),
            (inv.igstTotal / 100).toStringAsFixed(2),
            (inv.ugstTotal / 100).toStringAsFixed(2),
            (inv.total / 100).toStringAsFixed(2),
          ]),
      ...b2cByRate.entries.map((e) => [
            'B2C',
            '-',
            '-',
            '-',
            '-',
            '-',
            (e.value / 100).toStringAsFixed(2),
            '-',
            '-',
            '-',
            '-',
            (e.value / 100).toStringAsFixed(2),
          ]),
      // Negative values — these reduce the period's total liability
      ...cdnr.map((note) => [
            'CDNR',
            note.invoiceNumber,
            note.originalInvoiceNumber ?? '-',
            note.customerGstin ?? '',
            note.customerName ?? '',
            note.placeOfSupply ?? '',
            '-${(note.subtotal / 100).toStringAsFixed(2)}',
            '-${(note.cgstTotal / 100).toStringAsFixed(2)}',
            '-${(note.sgstTotal / 100).toStringAsFixed(2)}',
            '-${(note.igstTotal / 100).toStringAsFixed(2)}',
            '-${(note.ugstTotal / 100).toStringAsFixed(2)}',
            '-${(note.total / 100).toStringAsFixed(2)}',
          ]),
      ...cdnurByRate.entries.map((e) => [
            'CDNUR',
            '-',
            '-',
            '-',
            '-',
            '-',
            '-${(e.value / 100).toStringAsFixed(2)}',
            '-',
            '-',
            '-',
            '-',
            '-${(e.value / 100).toStringAsFixed(2)}',
          ]),
    ];
    await CsvExportService.exportAndShare(
        fileName: 'GSTR1_$periodLabel.csv'.replaceAll(' ', '_'), rows: rows);
  }
}
