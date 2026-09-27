import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/business/application/business_providers.dart';
import '../../purchases/data/purchase_bill_repository.dart';
import '../application/gst_report_providers.dart';
import '../presentation/widget/gst_period_picker.dart';

class ItcSummaryScreen extends ConsumerWidget {
  const ItcSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(gstReportPeriodNotifierProvider);
    final bizId = ref.watch(activeBusinessProvider).asData?.value?.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Tax Credit')),
      body: bizId == null
          ? const SizedBox.shrink()
          : StreamBuilder(
              stream: PurchaseBillRepository()
                  .streamForPeriod(bizId, period.start, period.end),
              builder: (context, snapshot) {
                final bills = snapshot.data ?? [];
                var cgst = 0, sgst = 0, igst = 0, ugst = 0;
                for (final b in bills) {
                  cgst += b.cgstTotal;
                  sgst += b.sgstTotal;
                  igst += b.igstTotal;
                  ugst += b.ugstTotal;
                }
                final totalItc = cgst + sgst + igst + ugst;

                return ListView(padding: const EdgeInsets.all(16), children: [
                  GstPeriodPicker(
                      label: period.label,
                      onPrevious: () => ref
                          .read(gstReportPeriodNotifierProvider.notifier)
                          .previous(),
                      onNext: () => ref
                          .read(gstReportPeriodNotifierProvider.notifier)
                          .next()),
                  const SizedBox(height: 20),
                  _row('Purchase Bills', '${bills.length}'),
                  const Divider(),
                  _row('CGST Credit', 'Rs.${(cgst / 100).toStringAsFixed(2)}'),
                  _row('SGST Credit', 'Rs.${(sgst / 100).toStringAsFixed(2)}'),
                  _row('IGST Credit', 'Rs.${(igst / 100).toStringAsFixed(2)}'),
                  _row('UGST Credit', 'Rs.${(ugst / 100).toStringAsFixed(2)}'),
                  const Divider(),
                  _row('Total Input Tax Credit',
                      'Rs.${(totalItc / 100).toStringAsFixed(2)}',
                      bold: true),
                ]);
              }),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) => Padding(
      padding: const EdgeInset.symmetric(vertical: 6),
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
}
