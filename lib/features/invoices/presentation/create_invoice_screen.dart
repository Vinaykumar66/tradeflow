// lib/features/invoices/presentation/create_invoice_screen.dart
//
// One screen for Invoice, Proforma Invoice, Estimate, and Quotation —
// selected via the Document Type dropdown. Payment recording is
// inline (POS-instant case) and only shown for real Invoices — the
// other three types are pre-sale documents with no payment obligation.
//
// Separate record_payment_screen.dart still exists and is still used
// from Invoice Detail — that's for a FOLLOW-UP payment on an invoice
// already created, which can happen weeks later and needs to be
// reachable again. This screen only covers "paid in full right now."

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/models/invoice.dart';
import '../../../shared/models/product.dart';
import '../application/invoice_providers.dart';
import '../../../shared/widgets/invoice_line_item_tile.dart';
import 'widgets/product_picker_sheet.dart';
import '../../../core/di/repository_providers.dart';
import 'invoice_scan_mode_screen.dart';

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  // Lets a future "New Quotation" quick action preset the type;
  // defaults to a normal invoice for the existing FAB/dashboard entry points.
  final String initialDocType;
  const CreateInvoiceScreen({super.key, this.initialDocType = kDocTypeInvoice});

  @override
  ConsumerState<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  late String _docType;

  Customer? _customer;
  List<InvoiceItem> _items = [];
  DateTime _issueDate = DateTime.now();
  DateTime? _dueDate;
  final _notesCtrl = TextEditingController();

  // Inline payment (Invoice type only)
  bool _recordPaymentLater = false;
  final _paymentAmountCtrl = TextEditingController();
  final _paymentRefCtrl = TextEditingController();
  String _paymentMethod = 'cash';

  int get _subtotal => _grandTotal - _taxTotal;
  int get _taxTotal => _items.fold(0, (s, i) => s + i.taxAmount);
  int get _grandTotal => _items.fold(0, (s, i) => s + i.lineTotal);

  @override
  void initState() {
    super.initState();
    _docType = widget.initialDocType;
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _paymentAmountCtrl.dispose();
    _paymentRefCtrl.dispose();
    super.dispose();
  }

  String _docLabel(String type) => switch (type) {
        kDocTypeProforma => 'Proforma Invoice',
        kDocTypeEstimate => 'Estimate',
        kDocTypeQuotation => 'Quotation',
        _ => 'Invoice',
      };

  void _addProduct(Product p) {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    final item = InvoiceItem(
            id: '',
            invoiceId: '',
            businessId: p.businessId,
            productId: p.id,
            name: p.name,
            unit: p.unit ?? 'pcs',
            unitPrice: p.sellingPrice,
            taxRate: p.taxRate,
            taxInclusive: p.taxInclusive,
            quantity: 1,
            hsnSacCode: p.hsnSacCode,
            commodityCode: p.commodityCode)
        .recalculate(sellerState: biz?.state, buyerState: _customer?.state);
    // setState(() => _items = [..._items, item]);

    setState(() {
      _items = [..._items, item];
      _paymentAmountCtrl.text = (_grandTotal / 100).toStringAsFixed(2);
    });
  }

  void _addOrIncrementProduct(Product p) {
    final existing = _items.indexWhere((i) => i.productId == p.id);
    if (existing >= 0) {
      _updateItem(existing,
          _items[existing].copyWith(quantity: _items[existing].quantity + 1));
    } else {
      _addProduct(p);
    }
  }

  void _updateItem(int idx, InvoiceItem updated) {
    final biz = ref.read(activeBusinessProvider).asData?.value;

    final list = [..._items];
    list[idx] = updated.recalculate(
        sellerState: biz?.state, buyerState: _customer?.state);
    // setState(() => );
    setState(() {
      _items = list;
      _paymentAmountCtrl.text = (_grandTotal / 100).toStringAsFixed(2);
    });
  }

  void _removeItem(int idx) {
    final list = [..._items]..removeAt(idx);
    setState(() => _items = list);
  }

  Future<String?> _checkStockAvailability() async {
    final bizId = ref.read(activeBusinessProvider).asData?.value?.id;
    if (bizId == null) return null;
    for (final item in _items) {
      if (item.productId == null) continue;
      final product = await ref
          .read(productRepositoryProvider)
          .getProduct(bizId, item.productId!);
      if (product == null || !product.trackInventory) continue;
      if (item.quantity > product.stockQty) {
        return '${item.name}: only ${product.stockQty} ${product.unit ?? "pcs"} '
            'in stock, but ${item.quantity.toStringAsFixed(0)} requested.';
      }
    }
    return null;
  }

  Future<void> _save() async {
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          showCloseIcon: true, content: Text('Add at least one product.')));
      return;
    }

    debugPrint('=== SAVE STARTED (docType=$_docType) ===');

    try {
      final stockIssue = await _checkStockAvailability();
      if (stockIssue != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(stockIssue),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4)));
        }
        return;
      }

      final biz = ref.read(activeBusinessProvider).asData?.value;
      if (biz == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Business not loaded yet. Try again in a moment.'),
              backgroundColor: Colors.red));
        }
        return;
      }
      final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';

      final inv = Invoice(
        id: '',
        businessId: biz.id,
        customerId: _customer?.id,
        invoiceNumber: '',
        documentType: _docType,
        issueDate: _issueDate,
        dueDate: _dueDate,
        subtotal: _subtotal,
        taxAmount: _taxTotal,
        total: _grandTotal,
        cgstTotal: _items.fold(0, (s, i) => s + i.cgstAmount),
        sgstTotal: _items.fold(0, (s, i) => s + i.sgstAmount),
        igstTotal: _items.fold(0, (s, i) => s + i.igstAmount),
        ugstTotal: _items.fold(0, (s, i) => s + i.ugstAmount),
        currencyCode: biz.currencyCode,
        currencySymbol: biz.currencySymbol,
        useLakhFormat: biz.useLakhFormat,
        customerGstin: _customer?.gstin,
        customerName: _customer?.name,
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        createdBy: uid,
        placeOfSupply: _customer?.state ?? biz.state,
      );

      final saved = await ref
          .read(saveInvoiceNotifierProvider.notifier)
          .save(inv, _items);

      if (saved == null) {
        final errorState = ref.read(saveInvoiceNotifierProvider);
        final err =
            errorState is AsyncError ? errorState.error : 'Unknown error';
        debugPrint('SAVE FAILED: $err');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to save: $err'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 6)));
        }
        return;
      }

      debugPrint('SAVED: ${saved.invoiceNumber}');

      // Only Invoices can take a payment — hidden in the UI for the
      // other three types, double-checked here as well.
      if (_docType == kDocTypeInvoice && !_recordPaymentLater) {
        final amount =
            ((double.tryParse(_paymentAmountCtrl.text) ?? 0) * 100).round();
        if (amount > 0) {
          try {
            await supabase.from('payments').insert({
              'business_id': biz.id,
              'invoice_id': saved.id,
              'customer_id': _customer?.id,
              'amount': amount,
              'method': _paymentMethod,
              'reference': _paymentRefCtrl.text.trim().isEmpty
                  ? null
                  : _paymentRefCtrl.text.trim(),
              'paid_at': DateTime.now().toIso8601String(),
              'created_by': uid,
            });
            final newStatus =
                amount >= saved.total ? kStatusPaid : kStatusPartial;
            await supabase.from('invoices').update({
              'amount_paid': amount,
              'status': newStatus,
            }).eq('id', saved.id);
            debugPrint('PAYMENT RECORDED: $amount ($newStatus)');
          } catch (e) {
            debugPrint('PAYMENT INSERT FAILED: $e');
            // Invoice already saved — make that unambiguous, since a
            // payment failure here does NOT mean nothing was saved.
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  showCloseIcon: true,
                  content: Text('${_docLabel(_docType)} saved as '
                      '${saved.invoiceNumber}, but recording payment failed: $e'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 10)));
              context.pop();
            }
            return;
          }
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('${_docLabel(_docType)} ${saved.invoiceNumber} saved.'),
            duration: const Duration(seconds: 2)));
        context.pop();
      }
    } catch (e, st) {
      debugPrint('SAVE EXCEPTION: $e');
      debugPrint('$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Save failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6)));
      }
    }
  }

  Future<void> _scanBarcode() async {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    if (biz == null) return;
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => InvoiceScanModeScreen(
            bizId: biz.id,
            sym: biz.currencySymbol,
            lakh: biz.useLakhFormat,
            onProductScanned: _addOrIncrementProduct)));
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final sym = biz?.currencySymbol ?? '';
    final lakh = biz?.useLakhFormat ?? false;
    final saving = ref.watch(saveInvoiceNotifierProvider) is AsyncLoading;
    final showGstSplit = biz?.countryCode == 'IN';

    String fmtAmt(int amt) =>
        CurrencyFormatter.format(amt, sym: sym, lakh: lakh);

    return Scaffold(
      appBar: AppBar(title: Text('New ${_docLabel(_docType)}'), actions: [
        TextButton(
            onPressed: saving ? null : _save,
            child: saving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : Text(!_recordPaymentLater ? 'SAVE & UPDATE PAYMENT' : 'SAVE',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Document type
        SizedBox(
          width: 2,
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField<String>(
                initialValue: _docType,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                decoration: const InputDecoration(
                  labelText: 'Document Type',
                ),
                items: const [
                  DropdownMenuItem(
                      value: kDocTypeInvoice, child: Text('Tax Invoice')),
                  DropdownMenuItem(
                      value: kDocTypeProforma, child: Text('Proforma Invoice')),
                  DropdownMenuItem(
                      value: kDocTypeEstimate, child: Text('Estimate')),
                  DropdownMenuItem(
                      value: kDocTypeQuotation, child: Text('Quotation')),
                ],
                onChanged: (v) => setState(() {
                      _docType = v ?? kDocTypeInvoice;
                      if (_docType != kDocTypeInvoice)
                        _recordPaymentLater = true;
                    })),
          ),
        ),
        const SizedBox(height: 20),

        // Customer
        Text('Customer', style: AppTextStyles.h3),
        const SizedBox(height: 8),
        InkWell(
            onTap: () async {
              final c = await context.push<Customer>(AppRoutes.customerPicker);
              if (c != null) setState(() => _customer = c);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                const Icon(Icons.person_outline, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(_customer?.name ?? 'Select Customer (optional)',
                        style: TextStyle(
                            color: _customer == null
                                ? Colors.grey
                                : Colors.black87))),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ]),
            )),
        const SizedBox(height: 20),

        // Dates
        Row(children: [
          Expanded(
              child: _datePicker(
                  label: 'Issue Date',
                  date: _issueDate,
                  onPick: (d) => setState(() => _issueDate = d))),
          const SizedBox(width: 12),
          Expanded(
              child: _datePicker(
                  label: 'Due Date (optional)',
                  date: _dueDate,
                  onPick: (d) => setState(() => _dueDate = d))),
        ]),
        const SizedBox(height: 20),

        // Items
        Row(children: [
          Text('Items', style: AppTextStyles.h3),
          const Spacer(),
          IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: 'Scan barcode',
              onPressed: _scanBarcode),
          TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
              onPressed: () => ProductPickerSheet.show(
                    context: context,
                    bizId: biz?.id ?? '',
                    onSelect: _addOrIncrementProduct,
                  )),
        ]),
        const SizedBox(height: 8),

        if (_items.isEmpty)
          Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200)),
              child: const Center(
                  child: Text('No items yet. Tap "Add Product"',
                      style: TextStyle(color: Colors.grey))))
        else
          ...List.generate(
              _items.length,
              (i) => InvoiceLineItemTile(
                  item: _items[i],
                  sym: sym,
                  lakh: lakh,
                  showGstSplit: showGstSplit,
                  onUpdate: (u) => _updateItem(i, u),
                  onDelete: () => _removeItem(i))),

        // InvoiceLineItemTile(
        //     item: _items[i],
        //     sym: sym,
        //     lakh: lakh,
        //     onUpdate: (u) => _updateItem(i, u),
        //     onDelete: () => _removeItem(i))),

        const Divider(height: 32),

        // Totals

        if (showGstSplit) ...[
          _totalRow('Subtotal', fmtAmt(_subtotal)),
          if (_items.any((i) => i.cgstAmount > 0))
            _totalRow(
                'CGST', fmtAmt(_items.fold(0, (s, i) => s + i.cgstAmount))),
          if (_items.any((i) => i.sgstAmount > 0))
            _totalRow(
                'SGST', fmtAmt(_items.fold(0, (s, i) => s + i.sgstAmount))),
          if (_items.any((i) => i.ugstAmount > 0))
            _totalRow(
                'UGST', fmtAmt(_items.fold(0, (s, i) => s + i.ugstAmount))),
          if (_items.any((i) => i.igstAmount > 0))
            _totalRow(
                'IGST', fmtAmt(_items.fold(0, (s, i) => s + i.igstAmount))),
        ] else ...[
          _totalRow('Subtotal', fmtAmt(_subtotal)),
          _totalRow('Tax', fmtAmt(_taxTotal)),
        ],
        const Divider(),
        _totalRow('Total', fmtAmt(_grandTotal), bold: true),

        //commenting this to add GST split conditional display of tax rows
        // _totalRow('Subtotal', fmtAmt(_subtotal)),
        // _totalRow('Tax', fmtAmt(_taxTotal)),
        // const Divider(),
        // _totalRow('Total', fmtAmt(_grandTotal), bold: true),
//commenting this to add GST split conditional display of tax rows

        // Inline payment — Invoice only
        if (_docType == kDocTypeInvoice) ...[
          const Divider(height: 32),
          Text('Payment', style: AppTextStyles.h3),
          const SizedBox(height: 4),
          SwitchListTile(
              contentPadding: EdgeInsets.zero,
              // title: const Text('Record payment now'),
              title: const Text('Record payment later'),
              subtitle: const Text(
                  'For counter/POS sales — otherwise use Record Payment later'),
              value: _recordPaymentLater,
              onChanged: (v) => setState(() {
                    _recordPaymentLater = v;
                    if (!v)
                      _paymentAmountCtrl.text =
                          (_grandTotal / 100).toStringAsFixed(2);
                  })),
          if (!_recordPaymentLater) ...[
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: TextFormField(
                      controller: _paymentAmountCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Amount Received', prefixText: '$sym '))),
              const SizedBox(width: 8),
              TextButton(
                  onPressed: () => setState(() => _paymentAmountCtrl.text =
                      // (_grandTotal / 100).toStringAsFixed(2)),
                      ''),
                  // child: const Text('Full')),
                  child: const Text('Clear')),
            ]),
            const SizedBox(height: 12),
            ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(12),
                  value: _paymentMethod,
                  decoration:
                      const InputDecoration(labelText: 'Payment Method'),
                  items: const [
                    DropdownMenuItem(value: 'cash', child: Text('Cash')),
                    DropdownMenuItem(value: 'upi', child: Text('UPI')),
                    DropdownMenuItem(
                        value: 'bank', child: Text('Bank Transfer')),
                    DropdownMenuItem(value: 'card', child: Text('Card')),
                    DropdownMenuItem(value: 'cheque', child: Text('Cheque')),
                  ],
                  onChanged: (v) =>
                      setState(() => _paymentMethod = v ?? _paymentMethod)),
            ),
            const SizedBox(height: 12),
            TextFormField(
                controller: _paymentRefCtrl,
                decoration:
                    const InputDecoration(labelText: 'Reference (optional)')),
          ],
        ],

        const SizedBox(height: 20),
        TextFormField(
            controller: _notesCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                hintText: 'Payment instructions, thank you note…')),
        const SizedBox(height: 32),
      ]),
    );
  }

  Widget _totalRow(String label, String value, {bool bold = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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

  Widget _datePicker({
    required String label,
    required DateTime? date,
    required void Function(DateTime) onPick,
  }) =>
      InkWell(
          onTap: () async {
            final d = await showDatePicker(
                context: context,
                initialDate: date ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2099));
            if (d != null) onPick(d);
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(label,
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  Text(
                      date == null
                          ? '--'
                          : '${date.day}/${date.month}/${date.year}',
                      style: const TextStyle(fontSize: 13)),
                ]),
              ])));
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../core/router/app_router.dart';
// import '../../../core/theme/app_colors.dart';
// import '../../../core/theme/app_text_styles.dart';
// import '../../../core/utils/currency_formatter.dart';
// import '../../../features/auth/application/auth_providers.dart';
// import '../../../features/business/application/business_providers.dart';
// import '../../../shared/models/customer.dart';
// import '../../../shared/models/invoice.dart';
// import '../../../shared/models/product.dart';
// import '../application/invoice_providers.dart';
// import '../../../shared/widgets/invoice_line_item_tile.dart';
// // import 'widgets/invoice_line_item_tile.dart';
// import 'widgets/product_picker_sheet.dart';
// import '../../../core/di/repository_providers.dart';
// import 'invoice_scan_mode_screen.dart';

// class CreateInvoiceScreen extends ConsumerStatefulWidget {
//   const CreateInvoiceScreen({super.key});
//   @override
//   ConsumerState<CreateInvoiceScreen> createState() =>
//       _CreateInvoiceScreenState();
// }

// class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
//   Customer? _customer;
//   List<InvoiceItem> _items = [];
//   DateTime _issueDate = DateTime.now();
//   DateTime? _dueDate;
//   final _notesCtrl = TextEditingController();

//   // Derived totals
//   int get _subtotal => _items.fold(0, (s, i) => s + i.lineTotal + i.taxAmount);
//   // Wait — subtotal = sum of (lineTotal without tax)
//   // lineTotal in recalculate() = afterDisc + tax (exclusive) or afterDisc (inclusive)
//   // For display: subtotal = sum of afterDisc (before tax)
//   int get _taxTotal => _items.fold(0, (s, i) => s + i.taxAmount);
//   int get _grandTotal => _items.fold(0, (s, i) => s + i.lineTotal);

//   @override
//   void dispose() {
//     _notesCtrl.dispose();
//     super.dispose();
//   }

//   // Add item from product picker
//   void _addProduct(Product p) {
//     final item = InvoiceItem(
//       id: '',
//       invoiceId: '',
//       businessId: p.businessId,
//       productId: p.id,
//       name: p.name,
//       unit: p.unit ?? 'pcs',
//       unitPrice: p.sellingPrice,
//       taxRate: p.taxRate,
//       taxInclusive: p.taxInclusive,
//       quantity: 1,
//     ).recalculate();
//     setState(() => _items = [..._items, item]);
//   }

//   // Scanning the same product twice should bump quantity, not create
// // a second line for the same item.
//   void _addOrIncrementProduct(Product p) {
//     final existing = _items.indexWhere((i) => i.productId == p.id);
//     if (existing >= 0) {
//       _updateItem(existing,
//           _items[existing].copyWith(quantity: _items[existing].quantity + 1));
//     } else {
//       _addProduct(p);
//     }
//   }

//   // Update a single line item
//   void _updateItem(int idx, InvoiceItem updated) {
//     final list = [..._items];
//     list[idx] = updated.recalculate();
//     setState(() => _items = list);
//   }

//   void _removeItem(int idx) {
//     final list = [..._items]..removeAt(idx);
//     setState(() => _items = list);
//   }

// // Checks every line item against current stock before saving.
// // Products with trackInventory = false are always allowed through —
// // this only guards items where stock actually means something.
// // Returns null if everything is fine, or a message describing the
// // first problem found.
//   Future<String?> _checkStockAvailability() async {
//     final bizId = ref.read(activeBusinessProvider).asData?.value?.id;
//     if (bizId == null) return null;

//     for (final item in _items) {
//       if (item.productId == null) continue;

//       final product = await ref
//           .read(productRepositoryProvider)
//           .getProduct(bizId, item.productId!);

//       if (product == null || !product.trackInventory) continue;

//       if (item.quantity > product.stockQty) {
//         return '${item.name}: only ${product.stockQty} ${product.unit ?? "pcs"} '
//             'in stock, but ${item.quantity.toStringAsFixed(0)} requested.';
//       }
//     }
//     return null;
//   }

// //   Future<void> _save() async {
// //     if (_items.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Add at least one product.')));
// //       return;
// //     }
// // // stock check runs before anything else touches Supabase
// //     try {
// //       final stockIssue = await _checkStockAvailability();
// //       if (stockIssue != null) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //               content: Text(stockIssue),
// //               backgroundColor: Colors.red,
// //               duration: const Duration(seconds: 4)));
// //         }
// //         return;
// //       }
// //     } catch (e, st) {
// //       debugPrint('Save failed: $e');
// //       debugPrint('$st');
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text('Save failed: $e'),
// //           backgroundColor: Colors.red,
// //           duration: const Duration(seconds: 6),
// //         ));
// //       }
// //     }

// //     final biz = ref.read(activeBusinessProvider).asData!.value!;
// //     final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';
// //     final inv = Invoice(
// //       id: '',
// //       businessId: biz.id,
// //       customerId: _customer?.id,
// //       invoiceNumber: '', // filled by repository
// //       issueDate: _issueDate,
// //       dueDate: _dueDate,
// //       subtotal: _grandTotal - _taxTotal,
// //       taxAmount: _taxTotal,
// //       total: _grandTotal,
// //       currencyCode: biz.currencyCode,
// //       currencySymbol: biz.currencySymbol,
// //       useLakhFormat: biz.useLakhFormat,
// //       notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
// //       createdBy: uid,
// //     );
// //     final saved =
// //         await ref.read(saveInvoiceNotifierProvider.notifier).save(inv, _items);
// //     if (mounted && saved != null) context.pop();
// //   }

//   Future<void> _save() async {
//     if (_items.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Add at least one product.')));
//       return;
//     }

//     debugPrint('=== SAVE INVOICE STARTED ===');

//     try {
//       debugPrint('Checking stock...');
//       final stockIssue = await _checkStockAvailability();
//       debugPrint('Stock check result: $stockIssue');
//       if (stockIssue != null) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(stockIssue),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 4)));
//         }
//         return;
//       }

//       // Safe check instead of asData!.value! — avoids a silent
//       // null-check crash if the provider hasn't resolved yet.
//       final biz = ref.read(activeBusinessProvider).asData?.value;
//       if (biz == null) {
//         debugPrint('SAVE ABORTED: business not loaded');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('Business not loaded yet. Try again in a moment.'),
//               backgroundColor: Colors.red));
//         }
//         return;
//       }
//       final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';
//       debugPrint('bizId=${biz.id} uid=$uid items=${_items.length}');

//       final inv = Invoice(
//         id: '',
//         businessId: biz.id,
//         customerId: _customer?.id,
//         invoiceNumber: '',
//         issueDate: _issueDate,
//         dueDate: _dueDate,
//         subtotal: _grandTotal - _taxTotal,
//         taxAmount: _taxTotal,
//         total: _grandTotal,
//         currencyCode: biz.currencyCode,
//         currencySymbol: biz.currencySymbol,
//         useLakhFormat: biz.useLakhFormat,
//         notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
//         createdBy: uid,
//       );

//       debugPrint('Calling save()...');
//       final saved = await ref
//           .read(saveInvoiceNotifierProvider.notifier)
//           .save(inv, _items);
//       debugPrint('save() returned: $saved');

//       if (saved != null) {
//         debugPrint('SAVE SUCCESS: ${saved.invoiceNumber}');
//         if (mounted) context.pop();
//         return;
//       }

//       // saved == null means the notifier swallowed an error — read its
//       // AsyncError state to get the real reason instead of doing nothing.
//       final errorState = ref.read(saveInvoiceNotifierProvider);
//       final err = errorState is AsyncError ? errorState.error : 'Unknown error';
//       debugPrint('SAVE FAILED — notifier error: $err');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Failed to save invoice: $err'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 6)));
//       }
//     } catch (e, st) {
//       debugPrint('SAVE EXCEPTION: $e');
//       debugPrint('$st');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('Save failed: $e'),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 6)));
//       }
//     }
//   }

//   Future<void> _scanBarcode() async {
//     final biz = ref.read(activeBusinessProvider).asData?.value;
//     if (biz == null) return;

//     await Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => InvoiceScanModeScreen(
//             bizId: biz.id,
//             sym: biz.currencySymbol,
//             lakh: biz.useLakhFormat,
//             onProductScanned: _addOrIncrementProduct)));
//   }

// //commenting to avoid screen exit after scan adding new code above
//   // Future<void> _scanBarcode() async {
//   //   final code = await context.push<String?>(AppRoutes.barcodeScanner);
//   //   if (code == null || !mounted) return;

//   //   final biz = ref.read(activeBusinessProvider).asData?.value;
//   //   if (biz == null) return;

//   //   final product = await ref
//   //       .read(productRepositoryProvider)
//   //       .getProductByBarcode(biz.id, code);

//   //   if (!mounted) return;

//   //   if (product != null) {
//   //     _addProduct(product); // existing method — same one the sheet uses
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text('Added: ${product.name}'),
//   //         duration: const Duration(seconds: 1)));
//   //   } else {
//   //     // No match on direct scan — fall back to the sheet, pre-filled
//   //     // with the scanned code, instead of silently doing nothing.
//   //     ProductPickerSheet.show(
//   //         context: context,
//   //         bizId: biz.id,
//   //         onSelect: _addProduct,
//   //         initialQuery: code);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final biz = ref.watch(activeBusinessProvider).asData?.value;
//     final sym = biz?.currencySymbol ?? '';
//     final lakh = biz?.useLakhFormat ?? false;
//     final saving = ref.watch(saveInvoiceNotifierProvider) is AsyncLoading;

//     String fmtAmt(int amt) =>
//         CurrencyFormatter.format(amt, sym: sym, lakh: lakh);

//     return Scaffold(
//       appBar: AppBar(title: const Text('New Invoice'), actions: [
//         TextButton(
//             onPressed: saving ? null : _save,
//             child: saving
//                 ? const SizedBox(
//                     height: 18,
//                     width: 18,
//                     child: CircularProgressIndicator(
//                         strokeWidth: 2, color: Colors.white))
//                 : const Text('SAVE',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ))),
//       ]),
//       body: ListView(padding: const EdgeInsets.all(16), children: [
//         // Customer picker
//         Text('Customer', style: AppTextStyles.h3),
//         const SizedBox(height: 8),
//         InkWell(
//             onTap: () async {
//               final c = await context.push<Customer>(AppRoutes.customerPicker);
//               if (c != null) setState(() => _customer = c);
//             },
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Row(children: [
//                 const Icon(Icons.person_outline, color: Colors.grey),
//                 const SizedBox(width: 8),
//                 Expanded(
//                     child: Text(_customer?.name ?? 'Select Customer (optional)',
//                         style: TextStyle(
//                             color: _customer == null
//                                 ? Colors.grey
//                                 : Colors.black87))),
//                 const Icon(Icons.chevron_right, color: Colors.grey),
//               ]),
//             )),
//         const SizedBox(height: 20),

//         // Issue date + Due date
//         Row(children: [
//           Expanded(
//               child: _datePicker(
//                   label: 'Issue Date',
//                   date: _issueDate,
//                   onPick: (d) => setState(() => _issueDate = d))),
//           const SizedBox(width: 12),
//           Expanded(
//               child: _datePicker(
//                   label: 'Due Date (optional)',
//                   date: _dueDate,
//                   onPick: (d) => setState(() => _dueDate = d))),
//         ]),
//         const SizedBox(height: 20),

//         // Line items header
//         Row(children: [
//           Text('Items', style: AppTextStyles.h3),
//           const Spacer(),
//           IconButton(
//               icon: const Icon(Icons.qr_code_scanner),
//               tooltip: 'Scan barcode',
//               onPressed: _scanBarcode),
//           TextButton.icon(
//               icon: const Icon(Icons.add),
//               label: const Text('Add Product'),
//               onPressed: () => ProductPickerSheet.show(
//                     context: context,
//                     bizId: biz?.id ?? '',
//                     onSelect: _addOrIncrementProduct,
//                     // _addProduct
//                   )),
//         ]),
//         const SizedBox(height: 8),

//         // Items list
//         if (_items.isEmpty)
//           Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey.shade200)),
//               child: const Center(
//                   child: Text('No items yet. Tap Add Product.',
//                       style: TextStyle(color: Colors.grey))))
//         else
//           ...List.generate(
//               _items.length,
//               (i) => InvoiceLineItemTile(
//                   item: _items[i],
//                   sym: sym,
//                   lakh: lakh,
//                   onUpdate: (u) => _updateItem(i, u),
//                   onDelete: () => _removeItem(i))),

//         const Divider(height: 32),

//         // Totals
//         _totalRow('Subtotal', fmtAmt(_grandTotal - _taxTotal)),
//         _totalRow('Tax', fmtAmt(_taxTotal)),
//         const Divider(),
//         _totalRow('Total', fmtAmt(_grandTotal), bold: true),

//         const SizedBox(height: 20),

//         // Notes
//         TextFormField(
//             controller: _notesCtrl,
//             maxLines: 3,
//             decoration: const InputDecoration(
//                 labelText: 'Notes (optional)',
//                 hintText: 'Payment instructions, thank you note…')),
//         const SizedBox(height: 32),
//       ]),
//     );
//   }

//   Widget _totalRow(String label, String value, {bool bold = false}) => Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
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

//   Widget _datePicker({
//     required String label,
//     required DateTime? date,
//     required void Function(DateTime) onPick,
//   }) =>
//       InkWell(
//           onTap: () async {
//             final d = await showDatePicker(
//                 context: context,
//                 initialDate: date ?? DateTime.now(),
//                 firstDate: DateTime(2020),
//                 lastDate: DateTime(2099));
//             if (d != null) onPick(d);
//           },
//           child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade300),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Row(children: [
//                 const Icon(Icons.calendar_today_outlined,
//                     size: 16, color: Colors.grey),
//                 const SizedBox(width: 6),
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text(label,
//                       style: const TextStyle(fontSize: 11, color: Colors.grey)),
//                   Text(
//                       date == null
//                           ? '--'
//                           : '${date.day}/${date.month}/${date.year}',
//                       style: const TextStyle(fontSize: 13)),
//                 ]),
//               ])));
// }
