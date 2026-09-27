import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/router/app_router.dart';
import '../../../features/business/application/business_providers.dart';
import '../../../shared/models/product.dart';
import '../../../shared/models/purchase_bill.dart';
import '../../../shared/models/vendor.dart';
import '../../invoices/presentation/widgets/product_picker_sheet.dart';
import '../data/purchase_bill_repository.dart';

class CreatePurchaseBillScreen extends ConsumerStatefulWidget {
  const CreatePurchaseBillScreen({super.key});

  @override
  ConsumerState<CreatePurchaseBillScreen> createState() =>
      _CreatePurchaseBillScreenState();
}

class _CreatePurchaseBillScreenState
    extends ConsumerState<CreatePurchaseBillScreen> {
  Vendor? _vendor;
  List<PurchaseBillItem> _items = [];
  final _billNumberCtrl = TextEditingController();
  DateTime _billDate = DateTime.now();
  bool _saving = false;

  int get _subtotal => _items.fold(
      0,
      (s, i) =>
          s +
          i.lineTotal -
          i.cgstAmount -
          i.sgstAmount -
          i.igstAmount -
          i.ugstAmount);

  int get _cgstTotal => _items.fold(0, (s, i) => s + i.cgstAmount);
  int get _sgstTotal => _items.fold(0, (s, i) => s + i.sgstAmount);
  int get _igstTotal => _items.fold(0, (s, i) => s + i.igstAmount);
  int get _ugstTotal => _items.fold(0, (s, i) => s + i.ugstAmount);
  int get _grandTotal => _items.fold(0, (s, i) => s + i.lineTotal);

  void _addProduct(Product p) {
    final biz = ref.read(activeBusinessProvider).asData?.value;
    final item = PurchaseBillItem(
      id: '',
      purchaseBillId: '',
      businessId: p.businessId,
      productId: p.id,
      name: p.name,
      unitPrice: p.costPrice,
      taxRate: p.taxRate,
      quantity: 1,
    ).recalculate(sellerState: _vendor?.state, buyerState: biz?.state);
    setState(() {
      _items = [..._items, item];
    });
  }

  Future<void> _save() async {
    if (_items.isEmpty || _billNumberCtrl.text.trim().isEmpty) return;
    final biz = ref.read(activeBusinessProvider).asData?.value;
    if (biz == null) return;

    setState(() {
      _saving = true;
    });
    try {
      final bill = PurchaseBill(
          id: '',
          businessId: biz.id,
          vendorId: _vendor?.id,
          billNumber: _billNumberCtrl.text.trim(),
          billDate: _billDate,
          subtotal: _subtotal,
          cgstTotal: _cgstTotal,
          sgstTotal: _sgstTotal,
          igstTotal: _igstTotal,
          ugstTotal: _ugstTotal,
          total: _grandTotal);
      await PurchaseBillRepository().create(bill, _items);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted)
        setState(() {
          _saving = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final biz = ref.watch(activeBusinessProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(title: const Text('New Purchase Bill'), actions: [
        TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('SAVE',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(
            controller: _billNumberCtrl,
            decoration: const InputDecoration(
                labelText: "Vendor's Bill Number *",
                hintText: 'e.g. INV-4521 as printed on their bill')),
        const SizedBox(height: 20),
        TextButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
            onPressed: () => ProductPickerSheet.show(
                context: context, bizId: biz?.id ?? '', onSelect: _addProduct)),
        if (_items.isNotEmpty)
          ..._items.map((i) => ListTile(
              title: Text(i.name),
              subtitle: Text('Qty ${i.quantity.toStringAsFixed(0)} - '
                  'Rs.${(i.unitPrice / 100).toStringAsFixed(2)} each'),
              trailing: Text('Rs.${(i.lineTotal / 100).toStringAsFixed(2)}'))),
        const Divider(),
        Text('Total: Rs.${(_grandTotal / 100).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ]),
    );
  }
}
