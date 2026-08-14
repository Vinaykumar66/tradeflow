import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../features/auth/application/auth_providers.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/customer.dart';
import '../../../shared/models/invoice.dart';
import '../../../shared/models/product.dart';
import '../application/invoice_providers.dart';
import '../../../shared/widgets/invoice_line_item_tile.dart';
import 'widgets/invoice_line_item_tile.dart';
import 'widgets/product_picker_sheet.dart';

class CreateInvoiceScreen extends ConsumerStatefulWidget {
  const CreateInvoiceScreen({super.key});
  @override
  ConsumerState<CreateInvoiceScreen> createState() =>
      _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends ConsumerState<CreateInvoiceScreen> {
  Customer? _customer;
  List<InvoiceItem> _items = [];
  DateTime _issueDate = DateTime.now();
  DateTime? _dueDate;
  final _notesCtrl = TextEditingController();

  // Derived totals
  int get _subtotal => _items.fold(0, (s, i) => s + i.lineTotal + i.taxAmount);
  // Wait — subtotal = sum of (lineTotal without tax)
  // lineTotal in recalculate() = afterDisc + tax (exclusive) or afterDisc (inclusive)
  // For display: subtotal = sum of afterDisc (before tax)
  int get _taxTotal => _items.fold(0, (s, i) => s + i.taxAmount);
  int get _grandTotal => _items.fold(0, (s, i) => s + i.lineTotal);

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  // Add item from product picker
  void _addProduct(Product p) {
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
    ).recalculate();
    setState(() => _items = [..._items, item]);
  }

  // Update a single line item
  void _updateItem(int idx, InvoiceItem updated) {
    final list = [..._items];
    list[idx] = updated.recalculate();
    setState(() => _items = list);
  }

  void _removeItem(int idx) {
    final list = [..._items]..removeAt(idx);
    setState(() => _items = list);
  }

  Future<void> _save() async {
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add at least one product.')));
      return;
    }
    final biz = ref.read(activeBusinessProvider).asData!.value!;
    final uid = ref.read(currentSupabaseUserProvider)?.id ?? '';
    final inv = Invoice(
      id: '',
      businessId: biz.id,
      customerId: _customer?.id,
      invoiceNumber: '', // filled by repository
      issueDate: _issueDate,
      dueDate: _dueDate,
      subtotal: _grandTotal - _taxTotal,
      taxAmount: _taxTotal,
      total: _grandTotal,
      currencyCode: biz.currencyCode,
      currencySymbol: biz.currencySymbol,
      useLakhFormat: biz.useLakhFormat,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      createdBy: uid,
    );
    final saved =
        await ref.read(saveInvoiceNotifierProvider.notifier).save(inv, _items);
    if (mounted && saved != null) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;
    final sym = biz?.currencySymbol ?? '';
    final lakh = biz?.useLakhFormat ?? false;
    final saving = ref.watch(saveInvoiceNotifierProvider) is AsyncLoading;

    String fmtAmt(int amt) =>
        CurrencyFormatter.format(amt, sym: sym, lakh: lakh);

    return Scaffold(
      appBar: AppBar(title: const Text('New Invoice'), actions: [
        TextButton(
            onPressed: saving ? null : _save,
            child: saving
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('SAVE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        // Customer picker
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

        // Issue date + Due date
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

        // Line items header
        Row(children: [
          Text('Items', style: AppTextStyles.h3),
          const Spacer(),
          TextButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
              onPressed: () => ProductPickerSheet.show(
                  context: context,
                  bizId: biz?.id ?? '',
                  onSelect: _addProduct)),
        ]),
        const SizedBox(height: 8),

        // Items list
        if (_items.isEmpty)
          Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200)),
              child: const Center(
                  child: Text('No items yet. Tap Add Product.',
                      style: TextStyle(color: Colors.grey))))
        else
          ...List.generate(
              _items.length,
              (i) => InvoiceLineItemTile(
                  item: _items[i],
                  sym: sym,
                  lakh: lakh,
                  onUpdate: (u) => _updateItem(i, u),
                  onDelete: () => _removeItem(i))),

        const Divider(height: 32),

        // Totals
        _totalRow('Subtotal', fmtAmt(_grandTotal - _taxTotal)),
        _totalRow('Tax', fmtAmt(_taxTotal)),
        const Divider(),
        _totalRow('Total', fmtAmt(_grandTotal), bold: true),

        const SizedBox(height: 20),

        // Notes
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
