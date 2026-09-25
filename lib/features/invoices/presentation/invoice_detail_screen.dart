// lib/features/invoices/presentation/invoice_detail_screen.dart
//
// The Invoice passed via `extra:` from the list is lightweight —
// status/total only, items always empty. This screen re-fetches the
// FULL invoice via invoiceDetailProvider the moment it opens.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tradeflow/core/di/repository_providers.dart';
import 'package:tradeflow/core/supabase/supabase_client.dart';
import 'package:tradeflow/shared/models/business.dart';
import '../../../core/interfaces/i_invoice_printer.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/eway_bill.dart';
import '../../../shared/models/invoice.dart';
import '../application/invoice_providers.dart';
// import '../data/invoice_pdf_generators.dart';
import 'widgets/invoice_status_badge.dart';
import '../data/printers/invoice_printer_registry.dart';
import 'widgets/print_format_picker_sheet.dart';
// import '../../../core/router/app_router.dart';
import '../data/einvoice_payload_builder.dart';
import 'widgets/transporter_details_sheet.dart';

class InvoiceDetailScreen extends ConsumerWidget {
  // Used for a fast initial app-bar title only — never trusted for items.
  final Invoice invoice;
  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullAsync = ref.watch(invoiceDetailProvider(invoice.id));
    final biz = ref.watch(activeBusinessProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(invoice.invoiceNumber),
        actions: [
          if (invoice.documentType != kDocTypeInvoice &&
              invoice.status != kStatusConverted)
            IconButton(
                icon: const Icon(Icons.receipt_long_outlined),
                tooltip: 'Convert to Invoice',
                onPressed: () => _convertToInvoice(context, ref, invoice)),
          //if eway bill is enabled
          if (biz?.ewayBillEnabled == true &&
              invoice.total >= (biz?.ewayBillThreshold ?? 5000000))
            IconButton(
              onPressed: () => _generateEwayBill(context, ref, invoice, biz!),
              tooltip: 'Generate E-Way Bill',
              icon: const Icon(Icons.local_shipping_outlined),
            ),
          //if einvoice is enabled show this icon
          if (biz?.einvoiceEnabled == true &&
              invoice.documentType == kDocTypeInvoice)
            invoice.einvoiceStatus == "generated"
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                        label: const Text('E-Invoiced',
                            style: TextStyle(fontSize: 11)),
                        backgroundColor: Colors.green.shade50,
                        avatar: const Icon(Icons.verified_outlined,
                            size: 14, color: Colors.green)))
                : IconButton(
                    icon: const Icon(Icons.qr_code_2_outlined),
                    tooltip: 'Generate E-Invoice',
                    onPressed: () =>
                        _generateEInvoice(context, ref, invoice, biz!)),

          if (invoice.status == kStatusConverted)
            Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(children: [
                      Icon(Icons.check_circle_outline,
                          color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                          child: Text(
                              'This document has already been converted to an invoice.')),
                    ]))),

          IconButton(
              icon: const Icon(Icons.print_outlined),
              tooltip:
                  'Tap to print with your default printer. Long-press to choose a different format.',
              onPressed:
                  //commented on 25Sep 2026 as li\ne item det was not being printed on invoice
                  // () => _print(context, ref, invoice, override: null),
                  //commented on 25Sep 2026 as li\ne item det was not being printed on invoice
                  fullAsync.asData?.value == null
                      ? null
                      : () => _print(context, ref, fullAsync.asData!.value!,
                          override: null),
              onLongPress: () async {
                final biz = ref.read(activeBusinessProvider).asData?.value;
                final chosen = await PrintFormatPickerSheet.show(
                    context, biz?.defaultPrintFormat ?? kPrintFormatLaser);
                if (chosen != null)
                  _print(context, ref, invoice, override: chosen);
              }),
          //Add this method to the screen:
        ],
      ),
      body: fullAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 8),
          Text('Failed to load invoice: $e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () =>
                  ref.invalidate(invoiceDetailProvider(invoice.id)),
              child: const Text('Retry')),
        ])),
        data: (full) => _InvoiceDetailBody(invoice: full ?? invoice),
      ),
      bottomNavigationBar: _paymentButton(context, fullAsync.asData?.value),
    );
  }

  Widget? _paymentButton(BuildContext context, Invoice? inv) {
    if (inv == null || inv.balanceDue <= 0) return null;
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    icon: const Icon(Icons.payments_outlined),
                    label: const Text('Record Payment'),
                    onPressed: () =>
                        context.push(AppRoutes.recordPayment, extra: inv)))));
  }

  Future<void> _print(BuildContext context, WidgetRef ref, Invoice inv,
      {String? override}) async {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    final customer = inv.customerId == null
        ? null
        : await ref
            .read(customerRepositoryProvider)
            .getCustomer(inv.businessId, inv.customerId!);
    if (biz == null) return;

    final formatKey = override ?? biz.defaultPrintFormat;
    final printer = invoicePrinterFor(formatKey);

    try {
      await printer.print(
          InvoicePrintJob(invoice: inv, business: biz, customer: customer));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Print failed: $e'), backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _convertToInvoice(
      BuildContext context, WidgetRef ref, Invoice inv) async {
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Convert to Invoice?'),
              content: Text(
                  'This creates a new tax invoice from ${inv.invoiceNumber} '
                  'with a real invoice number. The original document stays '
                  'as a record and is marked converted.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Convert')),
              ],
            ));
    if (confirmed != true) return;
    try {
      final newInvoice =
          await ref.read(invoiceRepositoryProvider).convertToInvoice(inv);
      ref.invalidate(invoiceDetailProvider(inv.id));
      if (context.mounted) {
        context.pushReplacement(AppRoutes.invoiceDetail, extra: newInvoice);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Conversion failed: $e'),
            backgroundColor: Colors.red));
      }
    }
  }

  Future<void> _generateEInvoice(
      BuildContext context, WidgetRef ref, Invoice inv, Business biz) async {
    try {
      final payload = EInvoicePayloadBuilder.build(invoice: inv, business: biz);
      debugPrint('E-Invoice payload: $payload');

      final result = await ref.read(einvoiceProviderProvider).generateIrn(inv);
      await supabase.from('invoices').update({
        'irn': result.irn,
        'ack_number': result.ackNumber,
        'ack_date': result.ackDate.toIso8601String(),
        'signed_qr_code': result.signedQrCode,
        'einvoice_statis': 'generated',
      }).eq('id', inv.id);
      ref.invalidate(invoiceDetailProvider(inv.id));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-Invoice generated successfully.')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('E-Invoice genereation failed: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          showCloseIcon: true,
        ));
      }
    }
  }

  Future<void> _generateEwayBill(
      BuildContext context, WidgetRef ref, Invoice inv, Business biz) async {
    final details = await TransporterDetailsSheet.show(context);
    if (details == null || !context.mounted) return;
    try {
      final draft = EwayBill(
          id: '',
          businessId: biz.id,
          invoiceId: inv.id,
          transporterName: details.transporterName,
          transporterGstin: details.transporterGstin,
          vehicleNumber: details.vehicleNumber,
          transportMode: details.transportMode,
          distanceKm: details.distanceKm);
      final result = await ref.read(ewayBillProviderProvider).generate(draft);
      await supabase.from('eway_bills').insert({
        'business_id': biz.id,
        'invoice_id': inv.id,
        'ebn': result.ebn,
        'transporter_name': details.transporterName,
        'transporter_gstin': details.transporterGstin,
        'vehicle_number': details.vehicleNumber,
        'transport_mode': details.transportMode,
        'distance_km': details.distanceKm,
        'valid_until': result.validUntil.toIso8601String(),
        'status': 'generated',
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('E-Way Bill generated: ${result.ebn}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('E-Way Bill generation failed: $e'),
            backgroundColor: Colors.red));
      }
    }
  }
}

// Only ever renders once the FULL invoice (with items) is ready.
class _InvoiceDetailBody extends StatelessWidget {
  final Invoice invoice;
  const _InvoiceDetailBody({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final sym = invoice.currencySymbol;
    final lakh = invoice.useLakhFormat;
    final fmt = (int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);

    return ListView(padding: const EdgeInsets.all(16), children: [
      Row(children: [
        InvoiceStatusBadge(status: invoice.status, overdue: invoice.isOverdue),
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
      Text('Items', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      if (invoice.items.isEmpty)
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('No items on this invoice',
                style: TextStyle(color: Colors.grey)))
      else
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
      _totalRow('Subtotal', fmt(invoice.subtotal)),
      if (invoice.discountAmount > 0)
        _totalRow('Discount', '-${fmt(invoice.discountAmount)}'),
      if (invoice.cgstTotal +
              invoice.sgstTotal +
              invoice.igstTotal +
              invoice.ugstTotal >
          0) ...[
        if (invoice.cgstTotal > 0) _totalRow('CGST', fmt(invoice.cgstTotal)),
        if (invoice.sgstTotal > 0) _totalRow('CGST', fmt(invoice.sgstTotal)),
        if (invoice.igstTotal > 0) _totalRow('CGST', fmt(invoice.igstTotal)),
        if (invoice.ugstTotal > 0) _totalRow('CGST', fmt(invoice.ugstTotal)),
      ] else
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
    ]);
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
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/router/app_router.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/utils/currency_formatter.dart';
// import '../../../features/business/application/business_providers.dart';
// import '../../../shared/models/invoice.dart';
// // import '../data/printers/invoice_printer_registry.dart';
// import '../application/invoice_providers.dart';
// import 'widgets/invoice_status_badge.dart';
// // import 'widgets/print_format_picker_sheet.dart';
// import '../../../features/invoices/presentation/record_payment_screen.dart';
// import '../../../features/invoices/data/invoice_pdf_generators.dart';

// class InvoiceDetailScreen extends ConsumerWidget {
//   final Invoice invoice;
//   const InvoiceDetailScreen({super.key, required this.invoice});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final biz = ref.watch(activeBusinessProvider).asData?.value;
//     final sym = invoice.currencySymbol;
//     final lakh = invoice.useLakhFormat;
//     final fmt = (int v) => CurrencyFormatter.format(v, sym: sym, lakh: lakh);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(invoice.invoiceNumber),
//         actions: [
//           // commented this for now and will be added again on day 33
//           // IconButton(
//           //     icon: const Icon(Icons.print_outlined),
//           //     tooltip: 'Tap to print with default printer. '
//           //         'Long-press to choose a format.',
//           //     onPressed: () => _print(context, ref, invoice, override: null),
//           //     onLongPress: () async {
//           //       final chosen = await PrintFormatPickerSheet.show(
//           //           context, biz?.defaultPrintFormat ?? kPrintFormatLaser);
//           //       if (chosen != null && context.mounted) {
//           //         _print(context, ref, invoice, override: chosen);
//           //       }
//           //     }),
// //added temporarily, this will be replaced by above commented icon button later
//           IconButton(
//               icon: const Icon(Icons.print_outlined),
//               tooltip: 'Print invoice',
//               onPressed: () => _print(context, ref, invoice)),
//         ],
//       ),
//       body: ListView(padding: const EdgeInsets.all(16), children: [
//         // Status + dates
//         Row(children: [
//           InvoiceStatusBadge(
//               status: invoice.status, overdue: invoice.isOverdue),
//           const Spacer(),
//           Text('Issued: ${_fmtDate(invoice.issueDate)}',
//               style: const TextStyle(color: Colors.grey, fontSize: 12)),
//         ]),
//         if (invoice.dueDate != null) ...[
//           const SizedBox(height: 4),
//           Text('Due: ${_fmtDate(invoice.dueDate!)}',
//               style: TextStyle(
//                   color: invoice.isOverdue ? Colors.red : Colors.grey,
//                   fontSize: 12)),
//         ],
//         const Divider(height: 32),

//         // Line items
//         Text('Items', style: Theme.of(context).textTheme.titleMedium),
//         const SizedBox(height: 8),
//         ...invoice.items.map((item) => Padding(
//             padding: const EdgeInsets.symmetric(vertical: 6),
//             child: Row(children: [
//               Expanded(flex: 3, child: Text(item.name)),
//               Expanded(
//                   flex: 1,
//                   child: Text(
//                       '${item.quantity.toStringAsFixed(0)} ${item.unit}',
//                       textAlign: TextAlign.center,
//                       style:
//                           const TextStyle(color: Colors.grey, fontSize: 13))),
//               Expanded(
//                   flex: 2,
//                   child: Text(fmt(item.lineTotal),
//                       textAlign: TextAlign.right,
//                       style: const TextStyle(fontWeight: FontWeight.w600))),
//             ]))),
//         const Divider(height: 32),

//         // Totals
//         _totalRow('Subtotal', fmt(invoice.subtotal)),
//         if (invoice.discountAmount > 0)
//           _totalRow('Discount', '-${fmt(invoice.discountAmount)}'),
//         _totalRow('Tax', fmt(invoice.taxAmount)),
//         const Divider(),
//         _totalRow('Total', fmt(invoice.total), bold: true),
//         if (invoice.amountPaid > 0) ...[
//           _totalRow('Amount Paid', fmt(invoice.amountPaid)),
//           _totalRow('Balance Due', fmt(invoice.balanceDue),
//               bold: true, color: Colors.red),
//         ],

//         if (invoice.notes != null) ...[
//           const SizedBox(height: 24),
//           Text('Notes', style: Theme.of(context).textTheme.titleSmall),
//           const SizedBox(height: 4),
//           Text(invoice.notes!, style: const TextStyle(color: Colors.grey)),
//         ],
//         const SizedBox(height: 32),
//       ]),

//       // Actions
//       bottomNavigationBar: invoice.balanceDue <= 0
//           ? null
//           : SafeArea(
//               child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton.icon(
//                           icon: const Icon(Icons.payments_outlined),
//                           label: const Text('Record Payment'),
//                           onPressed: () => context.push(AppRoutes.recordPayment,
//                               extra: invoice)))),
//             ),
//     );
//   }

//   Widget _totalRow(String label, String value,
//           {bool bold = false, Color? color}) =>
//       Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           child: Row(children: [
//             Text(label,
//                 style: TextStyle(
//                     fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
//             const Spacer(),
//             Text(value,
//                 style: TextStyle(
//                     fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//                     color: color ?? (bold ? AppColors.primary : null),
//                     fontSize: bold ? 16 : 14)),
//           ]));

//   String _fmtDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

// //   Future<void> _print(BuildContext context, WidgetRef ref, Invoice inv,
// //       {String? override}) async {
// //     final biz = ref.read(activeBusinessProvider).asData?.value;
// //     if (biz == null) return;

// //     final formatKey = override ?? biz.defaultPrintFormat;
// //     final printer = invoicePrinterFor(formatKey);

// //     try {
// //       await printer.print(InvoicePrintJob(invoice: inv, business: biz));
// //     } catch (e) {
// //       if (context.mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //             content: Text('Print failed: $e'), backgroundColor: Colors.red));
// //       }
// //     }
// //   }
// // }

// // added temporarilly above method will again be restored after day 33

//   Future<void> _print(BuildContext context, WidgetRef ref, Invoice inv) async {
//     final biz = ref.read(activeBusinessProvider).asData?.value;
//     if (biz == null) return;

//     try {
//       await InvoicePdfGenerator.generate(invoice: inv, business: biz);
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Print failed: $e'), backgroundColor: Colors.red));
//       }
//     }
//   }
// }
// // import 'package:flutter/material.dart';

// // class InvoiceDetailScreen extends StatelessWidget {
// //   const InvoiceDetailScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xF0FFFFFF),
// //         title: const Text(style: TextStyle(color: Colors.black), 'Invoices'),
// //       ),
// //       body: Center(
// //         child: Text('Invoice detail - coming soon'),
// //       ),
// //     );
// //   }
// // }
