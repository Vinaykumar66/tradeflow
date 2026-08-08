import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/auth/application/auth_providers.dart';
import '../../../../shared/models/product.dart';
import '../../application/inventory_providers.dart';

class StockUpdateSheet extends ConsumerStatefulWidget {
  final Product product;
  const StockUpdateSheet({super.key, required this.product});

  static Future<void> show(BuildContext context, Product product) =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (_) => StockUpdateSheet(product: product));

  @override
  ConsumerState<StockUpdateSheet> createState() => _StockUpdateSheetState();
}

class _StockUpdateSheetState extends ConsumerState<StockUpdateSheet> {
  late int _qty;
  final _qtyctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _qty = widget.product.stockQty;
    _qtyctrl.text = _qty.toString();
  }

  @override
  void dispose() {
    _qtyctrl.dispose();
    super.dispose();
  }

  void _inc() => setState(() {
        _qty++;
        _qtyctrl.text = _qty.toString();
      });
  void _dec() {
    if (_qty <= 0) {
      return;
    }
    setState(() {
      _qty--;
      _qtyctrl.text = _qty.toString();
    });
  }

  Future<void> _save() async {
    final bizId = ref.read(activeBusinessIdProvider) ?? '';
    await ref
        .read(updateStockNotifierProvider.notifier)
        .update(bizId: bizId, productId: widget.product.id, newQty: _qty);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final saving = ref.watch(updateStockNotifierProvider) is AsyncLoading;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 24,
          right: 24,
          top: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Text('Update Stock', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(widget.product.name, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton.filled(
                onPressed: _dec,
                icon: const Icon(Icons.remove),
                style: IconButton.styleFrom(
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(52, 52))),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _qtyctrl,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  final n = int.tryParse(value);
                  if (n != null && n >= 0)
                    setState(() {
                      _qty = n;
                    });
                },
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
                onPressed: _inc,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(52, 52))),
          ]),
          const SizedBox(height: 8),
          Text(
              'Current: ${widget.product.stockQty} ${widget.product.unit ?? 'pcs'}',
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 24),
          ElevatedButton(
              onPressed: saving ? null : _save,
              child: saving
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ))
                  : const Text('Update Stock')),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
