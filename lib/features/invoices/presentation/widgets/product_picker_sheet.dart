import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/supabase/supabase_client.dart';
import '../../../../shared/models/product.dart';

class ProductPickerSheet extends ConsumerStatefulWidget {
  final String bizId;
  final void Function(Product) onSelect;
  const ProductPickerSheet(
      {super.key, required this.bizId, required this.onSelect});

  static Future<void> show({
    required BuildContext context,
    required String bizId,
    required void Function(Product) onSelect,
  }) =>
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (ctx) => ProviderScope(
              child: ProductPickerSheet(bizId: bizId, onSelect: onSelect)));

  @override
  ConsumerState<ProductPickerSheet> createState() => _ProductPickerSheetState();
}

class _ProductPickerSheetState extends ConsumerState<ProductPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<Product> _results = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _search(''); // load all initially
  }

  Future<void> _search(String query) async {
    setState(() => _loading = true);
    try {
      final rows = await supabase
          .from('products')
          .select()
          .eq('business_id', widget.bizId)
          .eq('is_active', true)
          .or(query.isEmpty
              ? 'id.neq.null'
              : 'name.ilike.%$query%,sku.ilike.%$query%,barcode.eq.$query')
          .order('name')
          .limit(30);
      if (mounted)
        setState(() {
          _results = rows.map((r) => Product.fromJson(r)).toList();
          _loading = false;
        });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        builder: (_, ctrl) => Column(children: [
              const SizedBox(height: 8),
              Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2))),
              Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                      controller: _searchCtrl,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Search product name, SKU or scan barcode…',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onChanged: (v) => _search(v))),
              if (_loading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator()))
              else
                Expanded(
                    child: ListView.builder(
                        controller: ctrl,
                        itemCount: _results.length,
                        itemBuilder: (_, i) {
                          final p = _results[i];
                          return ListTile(
                              title: Text(p.name),
                              subtitle: Text(
                                  'SKU: ${p.sku}  |  Stock: ${p.stockQty}'),
                              trailing: Text(
                                  (p.sellingPrice / 100).toStringAsFixed(2)),
                              onTap: () {
                                Navigator.pop(context);
                                widget.onSelect(p);
                              });
                        })),
            ]));
  }
}
