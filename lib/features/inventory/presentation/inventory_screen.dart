import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/product.dart';
import '../../../shared/widgets/barcode_handler.dart';
import '../../../shared/widgets/stock_badge.dart';
import '../application/inventory_providers.dart';
import 'widgets/stock_update_sheet.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(inventoryFilterProvider);
    final invAsync = ref.watch(filterInventoryProvider);
    final lowStock = ref.watch(lowStockProductsProvider).valueOrNull ?? [];
    final expiring = ref.watch(expiringProductsProvider).valueOrNull ?? [];
    return Scaffold(
      body: Column(children: [
        //alert banners
        if (lowStock.isNotEmpty)
          _AlertBanner(
              icon: Icons.warning_amber_rounded,
              color: AppColors.alertAmber,
              message: '${lowStock.length} product(s) running low on stock',
              onTap: () =>
                  ref.read(inventoryFilterProvider.notifier).set('low')),
        if (expiring.isNotEmpty)
          _AlertBanner(
              icon: Icons.schedule_rounded,
              color: AppColors.alertRed,
              message: '${expiring.length} product(s) expiring within 30 days',
              onTap: () =>
                  ref.read(inventoryFilterProvider.notifier).set('expiring')),
        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(children: [
            for (final (label, value) in [
              ('All', 'all'),
              ('Low Stock', 'low'),
              ('Out of Stock', 'out'),
              ('Expiring', 'expiring')
            ])
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                    label: Text(label),
                    selected: filter == value,
                    onSelected: (_) =>
                        ref.read(inventoryFilterProvider.notifier).set(value)),
              ),
          ]),
        ),

//product list
        Expanded(
            child: invAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (products) => products.isEmpty
              ? const Center(child: Text('No products match this filter'))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, i) => _InventoryTile(product: products[i])),
        )),
      ]),
//Scan FAB for quick stock update
      floatingActionButton: FloatingActionButton(
          onPressed: () => BarcodeHandler.scanAndNavigate(
              context: context, ref: ref, title: 'Scan to update stock'),
          tooltip: 'Scan barcode',
          child: const Icon(Icons.qr_code_scanner)),
    );
  }
}

class _AlertBanner extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String message;
  final VoidCallback onTap;

  const _AlertBanner(
      {required this.icon,
      required this.color,
      required this.message,
      required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: color.withValues(alpha: 0.1),
        child: Row(children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(message,
                  style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w500))),
          Icon(Icons.chevron_right, color: color, size: 18),
        ]),
      ));
}

class _InventoryTile extends StatelessWidget {
  final Product product;
  const _InventoryTile({required this.product});
  @override
  Widget build(BuildContext context) {
    final (color, icon) = switch (product.stockStatus) {
      StockStatus.inStock => (AppColors.alertGreen, Icons.check_circle_outline),
      StockStatus.lowStock => (
          AppColors.alertAmber,
          Icons.warning_amber_outlined
        ),
      StockStatus.outOfStock => (AppColors.alertRed, Icons.cancel_outlined),
      StockStatus.notTracked => (Colors.grey, Icons.all_inclusive),
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color)),
        title: Text(product.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('SKU: ${product.sku}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Row(children: [
            StockBadge(product: product),
            const SizedBox(width: 6),
            ExpiryBadge(product: product),
          ]),
        ]),
        trailing: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${product.stockQty}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: color)),
                Text(product.unit ?? 'pcs',
                    style: const TextStyle(fontSize: 12, color: Colors.grey))
              ]),
        ),
        onTap: () => StockUpdateSheet.show(context, product),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class InventoryScreen extends StatelessWidget {
//   const InventoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inventory'),
//       ),
//       body: Center(
//         child: Text('Inventory - coming soon'),
//       ),
//     );
//   }
// }
