import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/invoice.dart';
// import '../data/printers/invoice_printer_registry.dart';
import '../application/invoice_providers.dart';
import 'widgets/invoice_status_badge.dart';
// import 'widgets/print_format_picker_sheet.dart';
import '../../../features/invoices/presentation/record_payment_screen.dart';
import '../../../features/invoices/data/invoice_pdf_generators.dart';

class InvoiceDetailScreen extends ConsumerWidget {
  final Invoice invoice;
  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final sym = invoice.currencySymbol;
    final lakh = invoice.useLakhFormat;
    final fmt = (int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);

    return Scaffold(
      appBar: AppBar(
        title: Text(invoice.invoiceNumber),
        actions: [
          // commented this for now and will be added again on day 33
          // IconButton(
          //     icon: const Icon(Icons.print_outlined),
          //     tooltip: 'Tap to print with default printer. '
          //         'Long-press to choose a format.',
          //     onPressed: () => _print(context, ref, invoice, override: null),
          //     onLongPress: () async {
          //       final chosen = await PrintFormatPickerSheet.show(
          //           context, biz?.defaultPrintFormat ?? kPrintFormatLaser);
          //       if (chosen != null && context.mounted) {
          //         _print(context, ref, invoice, override: chosen);
          //       }
          //     }),
//added temporarily, this will be replaced by above commented icon button later
          IconButton(
              icon: const Icon(Icons.print_outlined),
              tooltip: 'Print invoice',
              onPressed: () => _print(context, ref, invoice)),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Status + dates
        Row(children: [
          InvoiceStatusBadge(
              status: invoice.status, overdue: invoice.isOverdue),
          const Spacer(),
          Text('Issued: ${_fmtDate(invoice.issueDate)}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
        if (invoice.dueDate != null) ...[
          const SizedBox(height: 4),
          Text('Due: ${_fmtDate(invoice.dueDate!)}',
              style: TextStyle(
                  color: invoice.isOverdue ? Colors.red : Colors.grey,
                  fontSize: 12)),
        ],
        const Divider(height: 32),

        // Line items
        Text('Items', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...invoice.items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(children: [
              Expanded(flex: 3, child: Text(item.name)),
              Expanded(
                  flex: 1,
                  child: Text(
                      '${item.quantity.toStringAsFixed(0)} ${item.unit}',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 13))),
              Expanded(
                  flex: 2,
                  child: Text(fmt(item.lineTotal),
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.w600))),
            ]))),
        const Divider(height: 32),

        // Totals
        _totalRow('Subtotal', fmt(invoice.subtotal)),
        if (invoice.discountAmount > 0)
          _totalRow('Discount', '-${fmt(invoice.discountAmount)}'),
        _totalRow('Tax', fmt(invoice.taxAmount)),
        const Divider(),
        _totalRow('Total', fmt(invoice.total), bold: true),
        if (invoice.amountPaid > 0) ...[
          _totalRow('Amount Paid', fmt(invoice.amountPaid)),
          _totalRow('Balance Due', fmt(invoice.balanceDue),
              bold: true, color: Colors.red),
        ],

        if (invoice.notes != null) ...[
          const SizedBox(height: 24),
          Text('Notes', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          Text(invoice.notes!, style: const TextStyle(color: Colors.grey)),
        ],
        const SizedBox(height: 32),
      ]),

      // Actions
      bottomNavigationBar: invoice.balanceDue <= 0
          ? null
          : SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.payments_outlined),
                          label: const Text('Record Payment'),
                          onPressed: () => context.push(AppRoutes.recordPayment,
                              extra: invoice)))),
            ),
    );
  }

  Widget _totalRow(String label, String value,
          {bool bold = false, Color? color}) =>
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [
            Text(label,
                style: TextStyle(
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
            const Spacer(),
            Text(value,
                style: TextStyle(
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                    color: color ?? (bold ? AppColors.primary : null),
                    fontSize: bold ? 16 : 14)),
          ]));

  String _fmtDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

//   Future<void> _print(BuildContext context, WidgetRef ref, Invoice inv,
//       {String? override}) async {
//     final biz = ref.read(activeBusinessProvider).asData?.value;
//     if (biz == null) return;

//     final formatKey = override ?? biz.defaultPrintFormat;
//     final printer = invoicePrinterFor(formatKey);

//     try {
//       await printer.print(InvoicePrintJob(invoice: inv, business: biz));
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Print failed: $e'), backgroundColor: Colors.red));
//       }
//     }
//   }
// }

// added temporarilly above method will again be restored after day 33

  Future<void> _print(BuildContext context, WidgetRef ref, Invoice inv) async {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    if (biz == null) return;

    try {
      await InvoicePdfGenerator.generate(invoice: inv, business: biz);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Print failed: $e'), backgroundColor: Colors.red));
      }
    }
  }
}
// import 'package:flutter/material.dart';

// class InvoiceDetailScreen extends StatelessWidget {
//   const InvoiceDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xF0FFFFFF),
//         title: const Text(style: TextStyle(color: Colors.black), 'Invoices'),
//       ),
//       body: Center(
//         child: Text('Invoice detail - coming soon'),
//       ),
//     );
//   }
// }
