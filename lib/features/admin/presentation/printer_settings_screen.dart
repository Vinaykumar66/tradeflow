import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/interfaces/i_invoice_printer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../features/business/application/business_providers.dart';

class PrinterSettingsScreen extends ConsumerWidget {
  const PrinterSettingsScreen({super.key});

  static const _formats = [
    (
      key: kPrintFormatLaser,
      label: 'Laser / Inkjet',
      desc: 'Full A4 page. Best for offices with a standard printer.',
      icon: Icons.print_outlined
    ),
    (
      key: kPrintFormatThermal,
      label: 'Thermal Receipt',
      desc: 'Narrow roll paper. Best for counters with a handheld printer.',
      icon: Icons.receipt_long_outlined
    ),
    (
      key: kPrintFormatDotMatrix,
      label: 'Dot Matrix',
      desc: 'Continuous stationery with pre-printed boxes.',
      icon: Icons.table_rows_outlined
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xF0FFFFFF),
          iconTheme: const IconThemeData(color: Color(0xFF2F4F4F)),
          title: const Text(
              style: TextStyle(color: Color(0xFF2F4F4F)), 'Printing')),
      body: ListView(children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Default Print Format',
                style: Theme.of(context).textTheme.titleMedium)),
        ..._formats.map((f) => RadioListTile<String>(
            value: f.key,
            // ignore: deprecated_member_use
            groupValue: biz?.defaultPrintFormat ?? kPrintFormatLaser,
            secondary: Icon(f.icon, color: AppColors.primary),
            title: Text(f.label),
            subtitle: Text(f.desc),
            // ignore: deprecated_member_use
            onChanged: (value) {
              if (value == null || biz == null) return;

              debugPrint('Updating defaultPrintFormat to: $value');
              ref
                  .read(updateBusinessNotifierProvider.notifier)
                  .update(biz.copyWith(defaultPrintFormat: value));
            })),
        if (biz?.defaultPrintFormat == kPrintFormatDotMatrix) ...[
          const Divider(),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Dot Matrix Alignment',
                  style: Theme.of(context).textTheme.titleMedium)),
          ListTile(
              title: const Text('Top margin (lines)'),
              subtitle: Slider(
                  value: (biz?.dotMatrixTopMarginLines ?? 3).toDouble(),
                  min: 0,
                  max: 15,
                  divisions: 15,
                  label: (biz?.dotMatrixTopMarginLines ?? 3).toString(),
                  onChanged: (v) => ref
                      .read(updateBusinessNotifierProvider.notifier)
                      .update(
                          biz!.copyWith(dotMatrixTopMarginLines: v.round())))),
          ListTile(
              title: const Text('Left margin (characters)'),
              subtitle: Slider(
                  value: (biz?.dotMatrixLeftMarginChars ?? 2).toDouble(),
                  min: 0,
                  max: 20,
                  divisions: 20,
                  label: (biz?.dotMatrixLeftMarginChars ?? 2).toString(),
                  onChanged: (v) => ref
                      .read(updateBusinessNotifierProvider.notifier)
                      .update(
                          biz!.copyWith(dotMatrixLeftMarginChars: v.round())))),
        ],
      ]),
    );
  }
}
